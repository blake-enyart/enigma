require './lib/class_helper'

class Enigma

  attr_reader :message, :key_master, :offset_master

  def initialize(offset_master=Date.today.strftime('%d%m%y'))
    @key_master = key_master
    @offset_master = offset_master
    @message = nil
  end

  def encrypt(message, key_master=@key_master, offset_master=@offset_master)
    @message=message
    @key_master=key_master
    @offset_master=offset_master
  end
end
