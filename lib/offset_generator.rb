module OffsetGenerator

  def offset_master_converter(offset_master=@offset_master)
    offset_master = offset_master.to_i**2
    offset_master.to_s[-4..-1]
  end
end
