require './test/test_helper'

class OffsetGeneratorTest < Minitest::Test

  def setup
    @offset_generator = OffsetGenerator.new
  end

  def test_it_exist

    assert_instance_of OffsetGenerator, @offset_generator
  end

  def test_date_stores_correctly

    assert_equal '040895', OffsetGenerator.new('040895').date
  end

  def test_defaults_to_today_stored_correctly

    assert_equal 6, @offset_generator.date.length
    assert_instance_of String, @offset_generator.date
  end

  def test_offset_master_generates_correctly

    assert_equal '1025', @offset_generator.offset_master('040895')
  end

  def test_offset_generator_defaults_to_today
    expected = Date.today.strftime('%d%m%y')

    assert_equal expected, @offset_generator.date
  end
end
