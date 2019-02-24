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
    message_file = read_in_file(input)

    encrypt_file(message_file, input)

    p "Created '#{input[1]}' with the key #{input[2]} and date #{input[3]}"
  end

  def read_in_file(input_array)
    file_path = './data/' + input_array[0]
    file = File.readlines(file_path)
    file = file.map { |line| line.chomp }
  end

  def encrypt_file(message_file, input)
    key = sampler()
    key = input[2]; date = input[3] if input.length > 2
    file_name = input[1]
    encryption_file_path = create_file(file_name)
    message_file.each do |line|
      encrypt_line(line, encryption_file_path, key, date)
    end
  end

  def encrypt_line(line, encryption_file_path, key, date)
    encryption_file = File.open(encryption_file_path, 'a')
    encryption_file.puts(encrypt(line, key, date)[:encryption])
    encryption_file.close
  end

  def create_file(file_name)
    file_location = './data/' + file_name
    file = File.open(file_location, 'w')
    file.close
    file_location = './data/' + file_name
  end
end
