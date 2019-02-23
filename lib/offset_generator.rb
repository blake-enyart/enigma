class OffsetGenerator

  attr_reader :date

  def initialize(date= Date.today.strftime('%d%m%y'))
    @date = date
  end

  def offset_master(date=@date)
    offset_master = date.to_i**2
    offset_master.to_s[-4..-1]
  end
end
