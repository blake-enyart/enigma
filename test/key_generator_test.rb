require './test/test_helper'

class KeyGeneratorTest < Minitest::Test

  def setup
    @enigma = Enigma.new
    @key_gen = KeyGenerator.new
  end

  def test_it_exist
    
    assert_instance_of KeyGenerator, @key_gen
  end
end
