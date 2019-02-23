class OffsetGenerator

  attr_reader :date, :a_offset, :b_offset, :c_offset, :d_offset

  def initialize(date= Date.today.strftime('%d%m%y'))
    @date = date

    offset_master = offset_master()
    @a_offset = offset_master[0]
    @b_offset = offset_master[1]
    @c_offset = offset_master[2]
    @d_offset = offset_master[3]

  end

  def offset_master(date=@date)
    offset_master = date.to_i**2
    offset_master.to_s[-4..-1]
  end
end
