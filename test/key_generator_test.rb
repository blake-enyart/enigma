require './test/test_helper'

class KeyGeneratorTest < Minitest::Test

  def setup
    @enigma = Enigma.new
    @key_gen = KeyGenerator.new
  end

  def test_it_exist

    assert_instance_of KeyGenerator, @key_gen
  end

  def test_sampler_returns_5_element_key_generator

    assert_equal 5, @key_gen.sampler
  end

  def test_key_maker_converts_key_choice_to_keys
    expected = ['01', '12', '23', '34']

    assert_equal expected, @key_gen.key_maker('01234')
  end
end
