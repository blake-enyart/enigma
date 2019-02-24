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

    assert_equal 6, @enigma.offset_master.length
    assert_equal 5, @enigma.key_master.length
  end

  def test_enigma_defaults_to_today_for_offset_master
    expected = Date.today.strftime('%d%m%y')

    assert_equal expected, @enigma.offset_master
  end

  def test_enigma_defaults_to_5_digit_random_number_for_key_master

    assert_equal 5, @enigma.key_master.length
  end

  def test_ivar_change_with_encrypt_method

    assert_nil @enigma.message

    expected = Date.today.strftime('%d%m%y')

    assert_equal expected, @enigma.offset_master
    assert_equal 5, @enigma.key_master.length

    @enigma.encrypt("hello world", "02715", "040895")

    assert_equal "hello world", @enigma.message
    assert_equal "02715", @enigma.key_master
    assert_equal "040895", @enigma.offset_master
  end

  def test_cipher_application_returns_correctly
    enigma = Enigma.new
    enigma.encrypt("hello world", "02715", "040895")

    assert_equal "keder ohulw", enigma.encryption
  end

  def test_cipher_shift_returns_correctly
    enigma = Enigma.new(offset_master: "040895", key_master: "02715")
    cipher = Shift.new(key_master: enigma.key_master, offset_master: enigma.offset_master).shift_master

    assert_equal "keder ohulw", enigma.cipher_shift("hello world", cipher)
  end

  def test_encrypt_returns_correctly
    expected = { encryption: "keder ohulw", key: "02715", date: "040895" }

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end

  def test_decrypt_returns_correctly
    expected = { decryption: "hello world", key: "02715", date: "040895" }

    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
  end
end
