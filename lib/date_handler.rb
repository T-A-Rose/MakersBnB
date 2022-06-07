require "date"

class DateHandler
  def initialize
  end

  def format(year, month, day)
    if month <= 12 && day < 31
      date = Date.new(year, month, day)
      return date.to_date.to_s
    else
      return "Invalid date format."
    end
  end
end
