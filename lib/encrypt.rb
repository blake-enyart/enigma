require 'date'
require './lib/command_decrypt'
require './lib/command_encrypt'
require './lib/encrypt_decrypt'
require './lib/shift'
require './lib/enigma'

enigma = Enigma.new

enigma.command_encrypt()
