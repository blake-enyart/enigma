require './test/test_helper'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exist

    assert_instance_of Enigma, @enigma
  end

  def test_attr_are_nil

    assert_nil @enigma.message
    assert_nil @enigma.key_master
    assert_nil @enigma.offset_master
  end

  def test_attr_change_with_encrypt_method
    assert_nil @enigma.message
    assert_nil @enigma.key_master
    assert_nil @enigma.offset_master

    @enigma.encrypt("hello world", "02715", "040895")

    assert_equal "hello world", @enigma.message
    assert_equal "02715", @enigma.key_master
    assert_equal "040895", @enigma.offset_master
  end

  def test_encrypt_returns_correctly
    skip
    expected = { encryption: "keder ohulw", key: "02715", date: "040895" }

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end

  def test_decrypt_returns_correctly
    skip
    expected = { decryption: "hello world", key: "02715", date: "040895" }

    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
  end
end
