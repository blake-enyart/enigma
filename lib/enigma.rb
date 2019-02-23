class Enigma

  attr_reader :offset_master, :key_master, :offset_master

  def initialize()
    @message = nil
    @key_master = nil
    @offset_master = nil
  end

  def encrypt(message, key_master, offset_master)
    @message = message
    @key_master = key_master
    @offset_master = offset_master
  end
end
