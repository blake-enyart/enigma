require './test/test_helper'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exist

    assert_instance_of Enigma, @enigma
  end

  def test_attr_return_correctly
    expected = [*'a'..'z'] << ' '

    assert_equal expected, @enigma.rotator
  end

  def test_encrypt_returns_correctly
    expected = { encryption: "keder ohulw", key: "02715", date: "040895" }

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end

  def test_encrypt_defaults_to_random_5_digit_key_and_today_for_date
    expected = Date.today.strftime('%d%m%y')

    assert_equal expected, @enigma.encrypt("keder ohulw")[:date]
    assert_equal 5, @enigma.encrypt("keder ohulw")[:key].length
  end

  def test_encrypt_returns_special_characters_untouched

    assert_equal '@!:', @enigma.encrypt('@!:')[:encryption]
    assert_equal 'keder ohulw!', @enigma.encrypt('hello world!', "02715", "040895" )[:encryption]
  end

  def test_encrypt_handles_uppercase_letters_correctly

    assert_equal 'keder ohulw!', @enigma.encrypt('HELLO WORLD!', "02715", "040895" )[:encryption]
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

  def test_decrypt_returns_special_characters_untouched

    assert_equal '@!:', @enigma.decrypt('@!:')[:decryption]
    assert_equal 'hello world!', @enigma.decrypt('keder ohulw!', "02715", "040895" )[:decryption]
  end

  def test_decrypt_handles_uppercase_letters_correctly

    assert_equal 'hello world!', @enigma.decrypt('KEDER OHULW!', "02715", "040895" )[:decryption]
  end

  def test_decrypt_reverses_encrypt_with_default_day_and_key_provided
    encrypted = @enigma.encrypt("hello world", "02715")
    expected = 'hello world'

    assert_equal expected, @enigma.decrypt(encrypted[:encryption], "02715")[:decryption]
  end

end
