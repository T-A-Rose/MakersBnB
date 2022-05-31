require "date"

class DateHandler
  def initialize()
  end

  def format(year, month, day)
    if month <= 12 && day < 31
      # Certain months have 30 days plus leap years' February
      date = Date.new(year, month, day)
      return date.to_date.to_s
    else
      return "Broooooooo...... Are you trying to fool me?"
    end
  end
end
