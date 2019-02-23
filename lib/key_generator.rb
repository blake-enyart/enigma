class KeyGenerator

  attr_reader :key

  def initialize(key=sampler())
    @key = key
  end

  def sampler
    key_array = [*00001..10000]
    key_master = key_array.sample
    key_master = "%05d" % key_master
  end

  def key_maker(key_master)
    choice_array = []
    key_master.chars.each_with_index do |number, index|
      if key_master[index+1] != nil
        choice_array << number + key_master[index+1]
      end
    end
    choice_array
  end
end
