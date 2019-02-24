require './lib/encrypt_decrypt'

class Enigma

  include EncryptDecrypt

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
    message_file = read_in_message(input)

    file_path = './data/' + input[1]
    encrypt_key = sampler()
    encrypt_file(file_path, message_file, encrypt_key)

    p "Created '#{input[1]}' with the key #{encrypt_key} and date #{encrypt("")[:date]}"
  end

  def read_in_message(input_array)
    file_path = './data/' + input_array[0]
    message_file = File.readlines(file_path)
    message_file = message_file.map { |line| line.chomp }
  end

  def encrypt_file(file_path, message_file, encrypt_key)
    encryption_file = File.open(file_path, 'w')
    encryption_file.close
    encrypt_each_line(message_file, file_path, encrypt_key)
  end

  def encrypt_each_line(message_file, file_path, encrypt_key)
    message_file.each do |line|
      encryption_file = File.open(file_path, 'a')
      encryption_file.puts(encrypt(line, encrypt_key)[:encryption])
      encryption_file.close
    end
  end

end
