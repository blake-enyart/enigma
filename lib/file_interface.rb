module FileInterface
  def read_in_file(file_name)
    file = File.readlines(file_name)
    file.map { |line| line.chomp }
  end

  def create_file(file_name)
    file = File.open(file_name, 'w')
    file.close
    file_name
  end
end
