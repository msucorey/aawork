require_relative "employee"
class Manager < Employee

  attr_accessor :employees, :name, :salary

  def initialize(name, title, salary, boss)
    @employees = []
    super #(name, title, salary, boss)
  end

  def bonus(multiplier)
    bonus = (subordinate_salaries(self) - salary) * multiplier
  end
require 'byebug'
  def subordinate_salaries(employee)
    return employee.salary if employee.class == Employee || employee.employees.size == 0
    result = employee.salary
    employee.employees.each do |person|
      result += subordinate_salaries(person)
    end
    result
  end

end

if __FILE__ == $PROGRAM_NAME

  ned = Manager.new("Ned", "Founder",1_000_000, nil)
  darren =  Manager.new("Darren", "TA Manager ",78_000, ned)
  shawana = Employee.new("Shawana", "TA", 12_000, darren)
  david = Employee.new("David", "TA", 10_000, darren)

  darren.employees = [shawana, david]
  ned.employees = [darren]

  p ned.bonus(5) # => 500_000
  p darren.bonus(4) # => 88_000
  p david.bonus(3) # => 30_000

end
