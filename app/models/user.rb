class User < ActiveRecord::Base

  validates :username, :presence => true, :uniqueness => true, length: { minimum: 6, maximum: 20 }

  validates :email, :presence => true, :uniqueness => true, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/,
  message: "format invalid" }

  validates :password, :presence => true, length: { minimum: 1, maximum: 20 },
    format: { with: /[aeiou]/,
    message: "must contain vowel" }

  validates :password, format: { without: /([abcdfghijklmnpqrstuvwxyz])\1/,
    message: "cannot contain two consecutive occurrences of the same letter, except for 'ee' or 'oo' " }

  validates :password, format: { without: /([a-z])\1\1/,
    message: "cannot contain three consecutive letters" }

  validates :password, format: { without: /[A-Z]|\d/,
    message: "cannot contain uppercase letters or digits" }

  before_save :downcase_password, :set_score


  #Methods
  def generate_password
    valid = false
    #Update to use non brute force
    while (valid == false) do
      range = [*'a'..'z']
      self.password = Array.new(8){range.sample}.join

      if self.password =~ /[aeiou]/
        valid = true
      end

      if self.password =~ /([abcdfghijklmnpqrstuvwxyz])\1/
        valid = false
      end

      if self.password =~ /([a-z])\1\1/
        valid = false
      end
    end

  end

  def self.lenght_score(input)
    score = 0
    if input.length < 8
      #Lenght Weak
    elsif (input.length >= 8) && (input.length < 16)
      #Lenght Medium
      score += 1
    else
      #Lenght Strong
      score += 2
    end
    return score
  end

  def self.char_score(input)
    total = User.count_occurrence(input)
    score = 0
    if total < 5
      #Count weak
    elsif (total >= 5) && (total < 10)
      #Count medium
      score += 1
    else
      #Count Strong
      score += 2
    end
    return score
  end


  def self.count_occurrence(input)
    total = 0
    #Check for occurrences of unqire letters
    ("a".."z").each do |letter|
      if input =~ /[#{letter}]/
        total += 1
      end
    end
    return total
  end



  #Callbacks
  protected
  def downcase_password
      self.password = self.password.downcase
  end

  def set_score
    #Debugging Info
    #puts "Lenght Score: " + (User.lenght_score(self.password)).to_s
    #puts "Char Score: " + (User.char_score(self.password)).to_s
    score = (User.lenght_score(self.password) + User.char_score(self.password))
    self.score = score
  end

end
