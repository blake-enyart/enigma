module FileInterface
  def read_in_file(file_name)
    file_path = './data/' + file_name
    file = File.readlines(file_path)
    file.map { |line| line.chomp }
  end

  def create_file(file_name)
    file_location = './data/' + file_name
    file = File.open(file_location, 'w')
    file.close
    file_location
  end
end
