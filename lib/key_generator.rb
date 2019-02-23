module KeyGenerator

  attr_reader :key, :a_key, :b_key, :c_key, :d_key

  def initialize(key=sampler())
    @key = key

    key_array = key_maker(@key)
    @a_key = key_array[0]
    @b_key = key_array[1]
    @c_key = key_array[2]
    @d_key = key_array[3]
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
