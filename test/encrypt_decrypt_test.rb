require './test/test_helper'

class EncryptDecryptTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_sampler_returns_5_digit_string_in_range
    choices = [*00001..99999]
    choices = choices.map { |number| "%05d" % number }

    assert_equal true, choices.include?(@enigma.sampler)
  end

  def test_cipher_shift_returns_correctly
    enigma = Enigma.new
    cipher = Shift.new(key_master: "02715", offset_master: "040895").shift_master

    assert_equal "keder ohulw", enigma.cipher_shift("hello world", cipher)
  end

  def test_element_converstion_returns_correctly
    cipher = Shift.new(key_master: '02715', offset_master: '040895').shift_master

    assert_equal '?', @enigma.element_conversion('?', 0, @enigma.rotator, cipher)
    assert_equal 'k', @enigma.element_conversion('h', 0, @enigma.rotator, cipher)
  end
end
