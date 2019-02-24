module CommandEncrypt

  def command_encrypt(input=ARGV)
    message_file_name, encrypt_file_name = input
    message_file = read_in_file(message_file_name)
    encrypt_file_path = create_file(encrypt_file_name)
    key, date = encrypt_file(message_file, encrypt_file_path, input)
    p "Created '#{encrypt_file_name}' with the key #{key} and date #{date}"
  end

  def encrypt_file(message_file, encrypt_file_path, input)
    key, date = input_filter(input)
    message_file.each do |line|
      encrypt_line(line, encrypt_file_path, key, date)
    end
    [key, date]
  end

  def encrypt_line(line, encryption_file_path, key, date)
    encryption_file = File.open(encryption_file_path, 'a')
    encryption_file.puts(encrypt(line, key, date)[:encryption])
    encryption_file.close
  end

  def input_filter(input)
    if input.length <= 2
      key = sampler(); date = Date.today.strftime('%d%m%y')
    else
      _, _, key, date = input
    end
    [key, date]
  end
end
