require './test/test_helper'

class CommandEncryptTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_command_encrypt_encrypts_message_correctly
    input_1 = 'message.txt'
    input_2 = 'encrypted.txt'
    key = "02715"
    date = "040895"
    input_array = [input_1, input_2, key, date]
    enigma = Enigma.new

    enigma.command_encrypt(input_array)
    expected = "keder ohulw,\n"

    assert_equal expected, File.readlines('./data/encrypted.txt')[0]
  end

  def test_command_encrypt_defaults_key_and_date_arguments
    input_1 = 'message.txt'
    input_2 = 'encrypted.txt'
    input_array = [input_1, input_2]
    enigma = Enigma.new

    assert enigma.command_encrypt(input_array)
  end

  def test_encrypt_file_defaults_to_today_and_random_5_digit_key
    input_1 = 'message.txt'
    input_2 = 'encrypted.txt'
    input_array = [input_1, input_2]
    message_file = @enigma.read_in_file(input_1)
    encrypt_file_path = @enigma.create_file(input_2)
    expected = Date.today.strftime('%d%m%y')
    #random 5 digit key test
    assert 5, @enigma.encrypt_file(message_file, encrypt_file_path, input_array)[0].length
    assert_equal expected, @enigma.encrypt_file(message_file, encrypt_file_path, input_array)[1]
  end

  def test_encrypt_line_returns_correctly
    line = 'hello world,'
    decrypt_location = './data/encrypted.txt'
    key = "02715"
    date = "040895"

    assert_equal 'keder ohulw,', @enigma.encrypt_line(line, decrypt_location, key, date)
  end
end
