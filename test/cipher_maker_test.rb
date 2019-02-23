require './test/test_helper'

class CipherMakerTest < Minitest::Test

  def setup
    @cipher_maker = CipherMaker.new
  end

  def test_it_exist

    assert_instance_of CipherMaker, @cipher_maker
  end
