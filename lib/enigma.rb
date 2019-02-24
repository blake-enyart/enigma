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
    input_array = input
    file_path = './data/' + input_array[0]
    message_file = File.readlines(file_path)
    message_file = message_file.map { |line| line.chomp }

    file_path = './data/' + input_array[1]
    encrypt_key = sampler()
    encryption_file = File.open(file_path, 'w')
    encryption_file.close
    message_file.each do |line|
      encryption_file = File.open(file_path, 'a')
      encryption_file.write(encrypt(line, encrypt_key)[:encryption])
      encryption_file.close
    end

    p "Created '#{input_array[1]}' with the key #{encrypt_key} and date #{encrypt("")[:date]}"
  end

end
