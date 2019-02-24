require './test/test_helper'

class CommandDecryptTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_command_decrypt_decrypts_message_correctly
    input_1 = 'message.txt'
    input_2 = 'encrypted.txt'
    key = "02715"
    date = "040895"
    input_array = [input_1, input_2, key, date]
    enigma = Enigma.new

    enigma.command_encrypt(input_array)

    input_1 = 'encrypted.txt'
    input_2 = 'decrypted.txt'
    key = "02715"
    date = "040895"
    input_array = [input_1, input_2, key, date]

    enigma.command_decrypt(input_array)
    expected = "hello world,\n"

    assert_equal expected, File.readlines('./data/decrypted.txt')[0]
  end

  def test_decrypt_line_returns_correctly
    line = 'keder ohulw,'
    decrypt_location = './data/decrypted.txt'
    key = "02715"
    date = "040895"

    assert_equal 'hello world,', @enigma.decrypt_line(line, decrypt_location, key, date)
  end
end
