class OffsetGenerator

  attr_reader :date

  def initialize(date= Date.today.strftime('%d%m%y'))
    @date = date
  end
end
