require './test/test_helper'

class CipherMakerTest < Minitest::Test

  def setup
    @enigma = Enigma.new
    # @enigma.encrypt("hello world", "02715", "040895")

    @cipher_maker = CipherMaker.new()
  end

  def test_it_exist

    assert_instance_of CipherMaker, @cipher_maker
  end

  def test_attr_return_correctly
    expected = OffsetGenerator.new('040895')

    assert_equal expected, @cipher_maker.offsets

    expected = KeyGenerator.new('02715')

    assert_equal expected, @cipher_maker.keys
    assert_equal 'hello_world', @cipher_maker.message
  end
end
