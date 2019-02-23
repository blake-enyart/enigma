require './test/test_helper'

class KeyGeneratorTest < Minitest::Test

  def setup
    @key_gen = KeyGenerator.new
  end

  def test_it_exist

    assert_instance_of KeyGenerator, @key_gen
  end

  def test_sampler_returns_5_element_key_generator

    assert_equal 5, @key_gen.sampler.chars.count
  end

  def test_key_maker_converts_key_choice_to_keys
    expected = ['01', '12', '23', '34']

    assert_equal expected, @key_gen.key_maker('01234')
  end

  def test_key_maker_output_assigned_to_correct_keys

    assert_equal '01', KeyGenerator.new('01234').a_key
    assert_equal '12', KeyGenerator.new('01234').b_key
    assert_equal '23', KeyGenerator.new('01234').c_key
    assert_equal '34', KeyGenerator.new('01234').d_key
  end

  def test_creation_of_key_generator_object_generates_random_key

    assert_equal 2, @key_gen.a_key.length
    assert_equal 2, @key_gen.b_key.length
    assert_equal 2, @key_gen.c_key.length
    assert_equal 2, @key_gen.d_key.length
  end
end
