require "date_handler"

RSpec.describe DateHandler do
  it("returns the formatted time") do
    datehandler = DateHandler.new()
    expect(datehandler.format(1999, 3, 4)).to eq("1999-03-04")
    expect(datehandler.format(2022, 5, 3)).to eq("2022-05-03")
    expect(datehandler.format(2123, 12, 5)).to eq("2123-12-05")
    expect(datehandler.format(9000, 3, 2)).to eq("9000-03-02")
  end
  it("fails if you are trying to fool it lightly") do
    datehandler = DateHandler.new()
    expect(datehandler.format(9000, 13, 32)).to eq("Broooooooo...... Are you trying to fool me?")
  end
end
