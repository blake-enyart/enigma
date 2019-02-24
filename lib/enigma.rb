require './lib/class_helper'

class Enigma

  attr_reader :message, :key_master, :offset_master, :cipher, :encryption

  def initialize(offset_master: Date.today.strftime('%d%m%y'), key_master: sampler())
    @key_master = key_master
    @offset_master = offset_master
    @message = nil
    @encryption = nil
    @cipher = Shift.new(key_master: key_master, offset_master: offset_master).shift_master
  end

  def sampler
    key_array = [*00001..99999]
    key_master = key_array.sample
    key_master = "%05d" % key_master
  end

  def encrypt(message, key_master=@key_master, offset_master=@offset_master)
    @cipher = Shift.new(key_master: key_master, offset_master: offset_master).shift_master
    @message=message
    @key_master=key_master
    @offset_master=offset_master

    cipher_shift(message, @cipher)
  end

  #Encrypt module
  def cipher_shift(message, cipher)
    rotator = [*'a'..'z'] << ' '
    message.chars.each_with_index do |letter, index|
      if index
      letter_location = rotator.index(letter)
      shifted_rotator = rotator.rotate(cipher['A'])
      shifted_rotator[letter_location]
      binding.pry
    end
  end
end
