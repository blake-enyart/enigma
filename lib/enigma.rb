require './lib/class_helper'

class Enigma

  attr_reader :message, :encryption, :decryption

  def initialize
    @message = nil
    @encryption = nil
    @decryption = nil
    @rotator = [*'a'..'z'] << ' '
  end

  def sampler
    key_array = [*00001..99999]
    key_master = key_array.sample
    key_master = "%05d" % key_master
  end

  def encrypt(message, key_master=sampler(), offset_master=Date.today.strftime('%d%m%y'))
    cipher = Shift.new(key_master: key_master, offset_master: offset_master).shift_master
    @message=message
    @encryption = cipher_shift(message, cipher)
    { encryption: @encryption, key: key_master, date: offset_master }
  end

  #Encrypt and decrypt module
  def cipher_shift(message, cipher, rotator=@rotator)
    message = message.downcase
    translation = ""
    message.chars.each_with_index do |letter, index|
       translation << element_conversion(letter, index, rotator, cipher)
    end
    translation
  end

  def element_conversion(letter, index, rotator, cipher)
    return letter if !rotator.include?(letter)
    letter_location = rotator.index(letter)
    shifted_rotator = rotator.rotate(cipher[index % 4])
    shifted_rotator[letter_location]
  end

  #decrypt method and module methods
  def decrypt(encryption, key_master=sampler(), offset_master=Date.today.strftime('%d%m%y'))
    decrypt_cipher = Shift.new(key_master: key_master, offset_master: offset_master).shift_master
    decrypt_cipher = decrypt_cipher.map { |shift_key| -shift_key }
    @encryption = encryption
    @decryption=cipher_shift(encryption, decrypt_cipher)
    { decryption: @decryption, key: key_master, date: offset_master }
  end
end
