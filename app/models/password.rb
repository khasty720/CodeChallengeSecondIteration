class Password < ActiveRecord::Base

require 'open-uri'

  def self.import(input)
    puts "Input: " + input.path
    Password.delete_all

    File.open(input.path).readlines.each do |line|
      line = line.chomp
      if line == "end"
        return
      else
        pass = Password.new
        pass.name = line
        pass.test
        pass.save
      end

      Password.write_to_file(Password.all)
    end
  end

  def self.write_to_file(passwords)
      file = File.open("out.txt", "w")
      passwords.each do |p|
        if p.val_password == true
          file.puts "<" + p.name + ">" + " is acceptable."
        else
          file.puts "<" + p.name + ">" + " is  not acceptable."
        end
      end
      file.close
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
     if self.name =~ /([a-z])\1\1/
       self.val_password = false
       self.save
     end
  end

end
