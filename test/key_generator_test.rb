require './test/test_helper'

class KeyGeneratorTest < Minitest::Test

  def setup
    @enigma = Enigma.new
    @key_gen = KeyGenerator.new
  end

  def test_it_exist

    assert_instance_of KeyGenerator, @key_gen
  end

  def test_sampler_returns_4_element_key_generator

    assert_equal 4, @key_gen.key.count
  end
end
