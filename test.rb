require 'date'

class User
  attr_reader :name, :date_of_birth, :today

  def initialize(name, date_of_birth, today)
    @name = name
    @date_of_birth = date_of_birth
    @today = today
  end



  # Returns an Integer representing the user's current age
  def age
    birthdate = Date.new(@today.year, @date_of_birth.month, @date_of_birth.day)
    years_old = @today.year - @date_of_birth.year
    return years_old - 1 if birthdate > @today
    return years_old
  end

  # Returns a Date object for the user's current upcoming birthday
  def next_birthday
    birthdate = Date.new(@today.year, @date_of_birth.month, @date_of_birth.day)
    if @today < birthdate
      return birthdate
    elsif @today >= birthdate
      return Date.new(@today.year + 1, @date_of_birth.month, @date_of_birth.day)
    end
  end
end



## Do not edit below here ##################################################

tests = [
  { in: { name: 'Year Start',  date_of_birth: Date.new(1990,  1,  1), today: Date.new(2021, 9, 16) }, out: { age: 31, next_birthday: Date.new(2022,  1,  1) } },
  { in: { name: 'Month Start', date_of_birth: Date.new(1990,  9,  1), today: Date.new(2021, 9, 16) }, out: { age: 31, next_birthday: Date.new(2022,  9,  1) } },
  { in: { name: 'Today',       date_of_birth: Date.new(1990,  9, 16), today: Date.new(2021, 9, 16) }, out: { age: 31, next_birthday: Date.new(2022,  9, 16) } },
  { in: { name: 'Month End',   date_of_birth: Date.new(1990,  9, 30), today: Date.new(2021, 9, 16) }, out: { age: 30, next_birthday: Date.new(2021,  9, 30) } },
  { in: { name: 'Year End',    date_of_birth: Date.new(1990, 12, 31), today: Date.new(2021, 9, 16) }, out: { age: 30, next_birthday: Date.new(2021, 12, 31) } },
  { in: { name: 'Tricky #1',   date_of_birth: Date.new(1992,  8,  8), today: Date.new(2021, 8,  7) }, out: { age: 28, next_birthday: Date.new(2021,  8,  8) } },
  { in: { name: 'Tricky #2',   date_of_birth: Date.new(1992,  8,  8), today: Date.new(2021, 8,  8) }, out: { age: 29, next_birthday: Date.new(2022,  8,  8) } },
]

tests.each do |test|
  user = User.new(test[:in][:name], test[:in][:date_of_birth], test[:in][:today])

  puts "#{'-' * 10} #{user.name} #{'-' * 10}"

  [:age, :next_birthday].each do |method|
    result = user.public_send(method)
    expected = test[:out][method]

    if result == expected
      puts "✅ #{method.to_s.upcase}: #{result}"
    else
      puts "❌ #{method.to_s.upcase}: expected #{expected} but got #{result}"
    end
  end

  puts
end