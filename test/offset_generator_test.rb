require './test/test_helper'

class OffsetGeneratorTest < Minitest::Test

  def setup
    @shift = Shift.new
  end

  def test_offset_master_converter_generates_correctly

    assert_equal '1025', @shift.offset_master_converter('040895')
  end

  def test_offset_assigns_each_offset_correctly
    enigma = Enigma.new(offset_master: '040895')
    @shift.assign_offset_keys(@shift.offset_master)

    assert_equal '1', offset_generator.a_offset
    assert_equal '0', offset_generator.b_offset
    assert_equal '2', offset_generator.c_offset
    assert_equal '5', offset_generator.d_offset
  end
end
