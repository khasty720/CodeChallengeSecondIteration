class User < ActiveRecord::Base

  validates :username, :presence => true, :uniqueness => true, length: { minimum: 6, maximum: 20 }

  validates :email, :presence => true, :uniqueness => true, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/,
  message: "format invalid" }

  #Password Validations
  has_secure_password

  validates :password, :presence => true, length: { minimum: 1, maximum: 20 }

  validates :password, format: { without: /\W|\d/,
    message: "cannot contain symbols or digits" }

  #Callbacks
  before_save :downcase_password, :set_score, :set_plain_text_pass

  #Methods
  def generate_password
    valid = false

    while (valid == false) do
      #Splat Opertaor http://stackoverflow.com/questions/918449/what-does-the-unary-operator-do-in-this-ruby-code
      range = [*'a'..'z']

      #http://stackoverflow.com/questions/3482149/how-do-i-pick-randomly-from-an-array
      #Sample method picks randomly from array
      #join converts the array to a string
      self.password = Array.new(8) {range.sample}.join

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


  #Callback Methods
  protected
  def downcase_password
      self.password = self.password.downcase
  end

  def set_score
    self.sum_score
    self.calc_score
    #Debugging Info
    logger.debug "[DEBUG] Score: " + self.score.to_s
    logger.debug "[DEBUG] Rating: " + self.rating
  end

  def set_plain_text_pass
    self.plain_text_pass = self.password
  end

end
