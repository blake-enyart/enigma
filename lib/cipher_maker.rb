require './lib/class_helper'

class CipherMaker < Enigma

  attr_reader :offsets, :keys, :message

  def initialize(message, offset_master, key_master)
    super
    @offset_master = offset_master
    @a_offset = 
    @keys = KeyGenerator.new(key_master)
    binding.pry
    @message = message
  end
end
