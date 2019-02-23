require './test/test_helper'

class OffsetGeneratorTest < Minitest::Test

  def setup
    @shift = Shift.new
  end

  def test_offset_master_converter_generates_correctly

    assert_equal '1025', @shift.offset_master_converter('040895')
  end

  def test_offset_master_converter_defaults_to_today
    expected = Date.today.strftime('%d%m%y')

    assert_equal expected, @shift.date
  end

  def test_offset_assigns_each_offset_correctly
    skip
    offset_generator = OffsetGenerator.new('040895')

    assert_equal '1', offset_generator.a_offset
    assert_equal '0', offset_generator.b_offset
    assert_equal '2', offset_generator.c_offset
    assert_equal '5', offset_generator.d_offset
  end
end
