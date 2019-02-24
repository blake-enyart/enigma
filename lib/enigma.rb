require './lib/encrypt_decrypt'
require './lib/command_decrypt'

class Enigma

  include EncryptDecrypt
  include CommandDecrypt

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

  def command_encrypt(input=ARGV)
    message_file_name, encrypt_file_name = input
    message_file = read_in_file(message_file_name)
    encrypt_file_path = create_file(encrypt_file_name)
    key, date = encrypt_file(message_file, encrypt_file_path, input)
    p "Created '#{encrypt_file_name}' with the key #{key} and date #{date}"
  end

  def encrypt_file(message_file, encrypt_file_path, input)
    key, date = input_filter(input)
    message_file.each do |line|
      encrypt_line(line, encrypt_file_path, key, date)
    end
    [key, date]
  end

  def encrypt_line(line, encryption_file_path, key, date)
    encryption_file = File.open(encryption_file_path, 'a')
    encryption_file.puts(encrypt(line, key, date)[:encryption])
    encryption_file.close
  end

  def input_filter(input)
    if input.length < 2
      key = sampler(); date = Date.today.strftime('%d%m%y')
    else
      _, _, key, date = input
    end
    [key, date]
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
