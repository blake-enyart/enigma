require './lib/encrypt_decrypt'
require './lib/command_decrypt'
require './lib/command_encrypt'
require './lib/file_interface'

class Enigma

  include EncryptDecrypt
  include CommandDecrypt
  include CommandEncrypt
  include FileInterface

  attr_reader :message, :encryption, :decryption, :rotator

  def initialize
    @rotator = [*'a'..'z'] << ' '
    @offset_default = Date.today.strftime('%d%m%y')
  end

  def encrypt(message, key_master=sampler(), offset_master=@offset_default)
    cipher = Shift.new(key_master: key_master, offset_master: offset_master).shift_master
    encryption = cipher_shift(message, cipher)
    { encryption: encryption, key: key_master, date: offset_master }
  end

  def decrypt(encryption, key_master=sampler(), offset_master=@offset_default)
    cipher = Shift.new(key_master: key_master, offset_master: offset_master).shift_master
    decrypt_cipher = cipher.map { |shift_key| -shift_key }
    decryption = cipher_shift(encryption, decrypt_cipher)
    { decryption: decryption, key: key_master, date: offset_master }
  end
end
