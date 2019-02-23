require './lib/class_helper'

class Shift < Enigma

  include OffsetGenerator

  attr_reader :a_shift, :b_shift, :c_shift, :d_shift, :offset_master, :key_master,
              :a_offset, :b_offset, :c_offset, :d_offset, :a_key, :b_key, :c_key,
              :d_key

  def initialize(key_master: sampler(), offset_master: Date.today.strftime('%d%m%y'))
    @a_shift = nil
    @b_shift = nil
    @c_shift = nil
    @d_shift = nil
    @a_offset = nil
    @b_offset = nil
    @c_offset = nil
    @d_offset = nil
    @a_key = nil
    @b_key = nil
    @c_key = nil
    @d_key = nil
    @key_master = key_master
    @offset_master = offset_master
  end

  def offset_master_converter(offset_master=@offset_master)
    offset_master = offset_master.to_i**2
    offset_master.to_s[-4..-1]
  end

  def assign_offset_letters(offset_master)
    @a_offset = offset_master[0]
    @b_offset = offset_master[1]
    @c_offset = offset_master[2]
    @d_offset = offset_master[3]
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

  def assign_key_letters(key_master)
    key_array = key_maker(key_master)
    @a_key = key_array[0]
    @b_key = key_array[1]
    @c_key = key_array[2]
    @d_key = key_array[3]
  end
end
