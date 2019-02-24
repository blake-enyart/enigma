require './test/test_helper'

class ShiftTest < Minitest::Test

  def setup
    @enigma = Enigma.new(key_master: '02715', offset_master: '040895')

    @shift = Shift.new(offset_master: @enigma.offset_master, key_master: @enigma.key_master)
  end

  def test_it_exist

    assert_instance_of Shift, @shift
  end

  def test_offset_master_converter_generates_correctly

    assert_equal '1025', @shift.offset_master_converter(@enigma.offset_master)
  end

  def test_key_maker_converts_key_choice_to_keys
    expected = ['02', '27', '71', '15']

    assert_equal expected, @shift.key_master_converter(@enigma.key_master)
  end

  def test_shift_instantiation_creates_shift_master_hash
    expected = {"A"=>3, "B"=>27, "C"=>73, "D"=>20}

    assert_equal expected, @shift.shift_master
  end
end
