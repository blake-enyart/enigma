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

  def crack(encryption, offset_master=@offset_default)
    encryption_master = encryption[-4..-1]
    encryption_key = encryption_master.dup

    key_master = sampler()
    key_array = [*00001..99999]
    key_array = key_array.map { |number| "%05d" % number }

    while key_array.length != 0
      key_master = crack_sampler(key_array)
      decryption = decrypt(encryption, key_master, offset_master)
      encryption_key = decryption[:decryption][-4..-1]
      if encryption_key == ' end'
        break
      end
      key_array.delete(key_master)
    end
  end

  def crack_sampler(key_array)
    key_array.sample
  end
end
