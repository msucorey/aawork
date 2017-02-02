# require_relative 'manager'

class Employee
  attr_reader :salary
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    @bonus = 0
  end

  def bonus(multiplier)
    @bonus = @salary * multiplier
  end

end
