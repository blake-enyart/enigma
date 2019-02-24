require './test/test_helper'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exist

    assert_instance_of Enigma, @enigma
  end

  def test_attr_return_correctly

    assert_nil @enigma.message
    assert_nil @enigma.encryption
  end



  def test_message_ivar_change_with_encrypt_method

    assert_nil @enigma.message

    @enigma.encrypt("hello world", "02715", "040895")

    assert_equal "hello world", @enigma.message
  end

  def test_cipher_application_returns_correctly
    enigma = Enigma.new
    enigma.encrypt("hello world", "02715", "040895")

    assert_equal "keder ohulw", enigma.encryption
  end

  def test_encrypt_returns_correctly
    expected = { encryption: "keder ohulw", key: "02715", date: "040895" }

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end

  def test_encrypt_defaults_date_to_today
    expected = Date.today.strftime('%d%m%y')

    assert_equal expected, @enigma.encrypt("keder ohulw", "02715")[:date]
  end

  def test_encrypt_defaults_to_random_5_digit_key_and_today_for_date
    expected = Date.today.strftime('%d%m%y')

    assert_equal expected, @enigma.encrypt("keder ohulw")[:date]
    assert_equal 5, @enigma.encrypt("keder ohulw")[:key].length
  end

  def test_decrypt_returns_correctly
    expected = { decryption: "hello world", key: "02715", date: "040895" }

    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_decrypt_defaults_date_to_today
    expected = Date.today.strftime('%d%m%y')

    assert_equal expected, @enigma.decrypt("keder ohulw", "02715")[:date]
  end

  def test_decrypt_defaults_to_random_5_digit_key_and_today_for_date
    expected = Date.today.strftime('%d%m%y')

    assert_equal expected, @enigma.decrypt("keder ohulw")[:date]
    assert_equal 5, @enigma.decrypt("keder ohulw")[:key].length
  end

  def test_cipher_shift_returns_special_characters_untouched

    assert_equal '@!:', @enigma.encrypt('@!:')[:encryption]
    assert_equal 'keder ohulw!', @enigma.encrypt('hello world!', "02715", "040895" )[:encryption]
  end

  def test_encrypt_handles_uppercase_letters_correctly

    assert_equal 'keder ohulw!', @enigma.encrypt('HELLO WORLD!', "02715", "040895" )[:encryption]
  end

  def test_decrypt_returns_special_characters_untouched

    assert_equal '@!:', @enigma.decrypt('@!:')[:decryption]
    assert_equal 'hello world!', @enigma.decrypt('keder ohulw!', "02715", "040895" )[:decryption]
  end

  def test_decrypt_handles_uppercase_letters_correctly

    assert_equal 'hello world!', @enigma.decrypt('KEDER OHULW!', "02715", "040895" )[:decryption]
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
    input_1 = 'encrypted.txt'
    input_2 = 'decrypted.txt'
    input_array = [input_1, input_2]
    enigma = Enigma.new

    assert enigma.command_encrypt(input_array)
  end
end
