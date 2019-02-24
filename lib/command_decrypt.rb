module CommandDecrypt
  def command_decrypt(input=ARGV)
    encrypted_name, decrypted_file_name, key, date = input
    encrypted_file = read_in_file(encrypted_name)
    decrypt_file(encrypted_file, decrypted_file_name, key, date)
    p "Created '#{decrypted_file_name}' with the key #{key} and date #{date}"
  end

  def decrypt_file(encrypted_file, decrypted_file_name, key, date)
    decrypt_location = create_file(decrypted_file_name)
    encrypted_file.each do |line|
      decrypt_line(line, decrypt_location, key, date)
    end
  end

  def decrypt_line(line, decrypt_location, key, date)
    decrypted_file = File.open(decrypt_location, 'a')
    decrypted_file.puts(decrypt(line, key, date)[:decryption])
    decrypted_file.close
    decrypt(line, key, date)[:decryption]
  end
end
