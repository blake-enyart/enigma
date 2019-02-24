class Shift < Enigma

  attr_reader :shift_master

  def initialize(key_master:, offset_master:)
    @shift_master = []
    assign_shift_letters(key_master, offset_master)
  end

  def assign_shift_letters(key_master, offset_master)
    offset_values = offset_master_converter(offset_master)
    key_values = key_master_converter(key_master)
    shift_keys = [*'A'..'D']
    shift_keys.each_with_index do |key,index|
      @shift_master << key_values[index].to_i + offset_values[index].to_i
    end
  end

  def offset_master_converter(offset_master)
    squared_master = offset_master.to_i**2
    squared_master.to_s[-4..-1]
  end

  def key_master_converter(key_master)
    choice_array = []
    key_master.chars.each_with_index do |number, index|
      if key_master[index+1] != nil
        choice_array << number + key_master[index+1]
      end
    end
    choice_array
  end
end
