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

  def test_offset_master_converter_generates_correctly

    assert_equal '1025', @shift.offset_master_converter('040895')
  end

  def test_offset_assigns_each_offset_correctly
    @shift.assign_offset_letters('1025')

    assert_equal '1', @shift.a_offset
    assert_equal '0', @shift.b_offset
    assert_equal '2', @shift.c_offset
    assert_equal '5', @shift.d_offset
  end

  def test_key_maker_converts_key_choice_to_keys
    expected = ['02', '27', '71', '15']

    assert_equal expected, @shift.key_maker('02715')
  end

  def test_assign_key_letters_functions_correctly
    @shift.assign_key_letters('02715')

    assert_equal '02', @shift.a_key
    assert_equal '27', @shift.b_key
    assert_equal '71', @shift.c_key
    assert_equal '15', @shift.d_key
  end

  def test_shift_defaults_to_5_digit_random_number_for_key_master
    
    assert_equal 5, Shift.new.key_master.length
  end

  def test_attr_return_correctly
    skip
    assert_equal 3, @shift.a_shift
    assert_equal 27, @shift.b_shift
    assert_equal 73, @shift.c_shift
    assert_equal 20, @shift.d_shift
  end
end
