require './test/test_helper'

class OffsetGeneratorTest < Minitest::Test

  def setup
    @offset_generator = OffsetGenerator.new
  end

  def test_it_exist

    assert_instance_of OffsetGenerator, @offset_generator
  end

  def test_date_stores_correctly

    assert_equal '020419', OffsetGenerator.new('020419').date
  end

  def test_defaults_to_today_stored_correctly

    assert_equal 6, @offset_generator.date.length
    assert_instance_of String, @offset_generator.date
  end
end
