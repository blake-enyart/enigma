require './lib/encrypt_decrypt'
require './lib/command_decrypt'
require './lib/command_encrypt'

class Enigma

  include EncryptDecrypt
  include CommandDecrypt
  include CommandEncrypt

  attr_reader :message, :encryption, :decryption, :rotator

  def initialize
    @message = nil
    @encryption = nil
    @decryption = nil
    @rotator = [*'a'..'z'] << ' '
  end

  def encrypt(message, key_master=sampler(), offset_master=Date.today.strftime('%d%m%y'))
    cipher = Shift.new(key_master: key_master, offset_master: offset_master).shift_master
    @message=message
    @encryption = cipher_shift(message, cipher)
    { encryption: @encryption, key: key_master, date: offset_master }
  end

  def decrypt(encryption, key_master=sampler(), offset_master=Date.today.strftime('%d%m%y'))
    decrypt_cipher = Shift.new(key_master: key_master, offset_master: offset_master).shift_master
    decrypt_cipher = decrypt_cipher.map { |shift_key| -shift_key }
    @encryption = encryption
    @decryption=cipher_shift(encryption, decrypt_cipher)
    { decryption: @decryption, key: key_master, date: offset_master }
  end

  def read_in_file(file_name)
    file_path = './data/' + file_name
    file = File.readlines(file_path)
    file.map { |line| line.chomp }
  end

  def create_file(file_name)
    file_location = './data/' + file_name
    file = File.open(file_location, 'w')
    file.close
    file_location
  end
end
