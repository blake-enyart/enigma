require './test/test_helper'

class OffsetGeneratorTest < Minitest::Test

  def setup
    @offset_generator = OffsetGenerator.new
  end

  def test_it_exist

    assert_instance_of OffsetGenerator, @offset_generator
  end

  def test_today_generator_stored_correctly

    assert_equal 6, @offset_generator.today.length
    assert_instance_of String, @offset_generator.today
  end
end
