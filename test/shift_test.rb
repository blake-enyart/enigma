require './test/test_helper'

class ShiftTest < Minitest::Test

  def setup
    @enigma = Enigma.new
    @enigma.encrypt("hello world", "02715", "040895")

    @shift = Shift.new
  end

  def test_it_exist

    assert_instance_of Shift, @shift
  end

  def test_attr_return_correctly

    assert_equal 3, @shift.a_shift
    assert_equal 27, @shift.b_shift
    assert_equal 73, @shift.c_shift
    assert_equal 20, @shift.d_shift
  end
end
