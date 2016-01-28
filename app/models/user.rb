class User < ActiveRecord::Base

  validates :username, :presence => true, :uniqueness => true, length: { minimum: 6, maximum: 20 }

  validates :email, :presence => true, :uniqueness => true, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/,
  message: "format invalid" }

  #Password Validations
  has_secure_password

  validates :password, :presence => true, length: { minimum: 1, maximum: 20 }
=begin
    ,format: { with: /[aeiou]/,
    message: "must contain vowel" }

  validates :password, format: { without: /([abcdfghijklmnpqrstuvwxyz])\1/,
    message: "cannot contain two consecutive occurrences of the same letter, except for 'ee' or 'oo' " }

  validates :password, format: { without: /([a-z])\1\1/,
    message: "cannot contain three consecutive letters" }
=end
  validates :password, format: { without: /\W|\d/,
    message: "cannot contain symbols or digits" }

  #Callbacks
  before_save :downcase_password, :set_score, :set_plain_text_pass
  #Methods
  def generate_password
    valid = false

=begin
    patterns = Pattern.joins(:weight).where("value > ?", 0)
    #Update to use non brute force
    while (valid == false) do
      range = [*'a'..'z']
      self.password = Array.new(16){range.sample}.join

        if self.password =~ /#{pattern.score_pattern}/
          valid = true
        else
          valid = false
        end
      end
    end
=end

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

#Password Scoring
=begin

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

=end
  def sum_score
    patterns = Pattern.all
    self.score = 0

    patterns.each do |pattern|
      #Debugging
      #puts pattern.score_pattern
      if self.password =~ /#{pattern.score_pattern}/
          self.score += pattern.weight.value
          #Debugging
          #puts "Sum Score: " + self.score.to_s
      end
    end
  end

  def calc_score
    max_score = 0
    patterns = Pattern.all

    #Sum positive score to determine max score
    patterns.each do |pattern|
      if pattern.weight.value > 0
        max_score += pattern.weight.value
      end
    end

    if self.score < (max_score / 3)
      self.rating = "weak"
    elsif (self.score >= (max_score / 3)) && (self.score < (max_score - (max_score / 3)))
      self.rating = "medium"
    else
      self.rating = "strong"
    end
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
    #score = (User.lenght_score(self.password) + User.char_score(self.password))
    #self.score = score

    self.sum_score
    self.calc_score
    puts "Score: " + self.score.to_s
    puts "Rating: " + self.rating

  end

  def set_plain_text_pass
    self.plain_text_pass = self.password
  end

end
