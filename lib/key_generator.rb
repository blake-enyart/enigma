class KeyGenerator

  attr_reader :key

  def initialize(key=sampler())
    @key = key
  end

  def sampler
    key_array = [*00001..10000]
    choice = key_array.sample
    choice = "%05d" % choice
    choice_array = []
    choice.chars.each_with_index do |number, index|
      if choice[index+1] != nil
        choice_array << number + choice[index+1]
      end
    end
    choice_array
  end
end
