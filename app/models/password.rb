class Password < ActiveRecord::Base

require 'open-uri'

  def self.import(input)

    File.open(input.path).readlines.each do |line|
      if line == "end"
        puts line
      else
        pass = Password.new
        pass.name = line
        pass.test
        pass.save

      end
    end
  end

  def test
    self.contains_vowel
    self.three_consecutive
    self.two_consecutive
  end

  def contains_vowel
    if self.name =~ /[aeiou]/
      self.val_password = true
      self.save
    end
  end

  def two_consecutive
    if self.name =~ /([abcdfghijklmnpqrstuvwxyz])\1/
      self.val_password = false
      self.save
    end
  end

  def three_consecutive
     if self.name =~ /([a-zA-Z])\1\1/
       self.val_password = false
       self.save
     end
  end
end
