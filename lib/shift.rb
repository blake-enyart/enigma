require './lib/class_helper'

class Shift < Enigma

  include OffsetGenerator

  attr_reader :a_shift, :b_shift, :c_shift, :d_shift, :offset_master, :key_master,
              :a_offset, :b_offset, :c_offset, :d_offset

  def initialize(key_master: sampler(), offset_master: Date.today.strftime('%d%m%y'))
    @a_shift = nil
    @b_shift = nil
    @c_shift = nil
    @d_shift = nil
    @a_offset = nil
    @b_offset = nil
    @c_offset = nil
    @d_offset = nil
    @key_master = key_master
    @offset_master = offset_master
  end

  def offset_master_converter(offset_master=@offset_master)
    offset_master = offset_master.to_i**2
    offset_master.to_s[-4..-1]
  end

  def assign_offset_keys(offset_master=@offset_master)
    @a_offset = offset_master[0]
    @b_offset = offset_master[1]
    @c_offset = offset_master[2]
    @d_offset = offset_master[3]
  end
end
