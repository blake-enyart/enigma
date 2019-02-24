require './test/test_helper'

class EncryptDecryptTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end
end
