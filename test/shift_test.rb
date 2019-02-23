require './test/test_helper'

class ShiftTest < Minitest::Test

  def setup
    @enigma = Enigma.new(key_master: '02715', offset_master: '040895')

    @shift = Shift.new(offset_master: @enigma.offset_master, key_master: @enigma.key_master)
  end

  def test_it_exist

    assert_instance_of Shift, @shift
  end

  def test_shift_defaults_to_today_for_offset
    shift = Shift.new
    expected = Date.today.strftime('%d%m%y')

    assert_equal expected, shift.offset_master
  end

  def test_attr_return_correctly

    assert_equal 3, @shift.a_shift
    assert_equal 27, @shift.b_shift
    assert_equal 73, @shift.c_shift
    assert_equal 20, @shift.d_shift
  end
end
