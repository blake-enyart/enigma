require './lib/class_helper'

class Enigma

  attr_reader :message, :key_master, :offset_master

  def initialize(offset_master: Date.today.strftime('%d%m%y'), key_master: sampler())
    @key_master = key_master
    @offset_master = offset_master
    @message = nil
    Shift.new(key_master: key_master, offset_master: offset_master)
  end

  def encrypt(message, key_master=@key_master, offset_master=@offset_master)
    @message=message
    @key_master=key_master
    @offset_master=offset_master
  end

  def sampler
    key_array = [*00001..99999]
    key_master = key_array.sample
    key_master = "%05d" % key_master
  end
end
