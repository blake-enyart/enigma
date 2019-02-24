module EncryptDecrypt

  def cipher_shift(message, cipher, rotator=@rotator)
    message = message.downcase
    translation = ""
    message.chars.each_with_index do |letter, index|
       translation << element_conversion(letter, index, rotator, cipher)
    end
    translation
  end

  def element_conversion(letter, index, rotator, cipher)
    return letter if !rotator.include?(letter)
    letter_location = rotator.index(letter)
    shifted_rotator = rotator.rotate(cipher[index % 4])
    shifted_rotator[letter_location]
  end

  def sampler
    key_array = [*00001..99999]
    key_master = key_array.sample
    key_master = "%05d" % key_master
  end
end
