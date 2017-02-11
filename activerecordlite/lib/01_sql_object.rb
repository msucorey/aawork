require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    return @columns if @columns
    @columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    .first.map(&:to_sym)
    @columns
  end

  def self.finalize!
    # debugger
    # Now we can finally write ::finalize!. It should iterate through
    #  all the ::columns, using define_method (twice) to create a getter
    #   and setter method for each column, just like my_attr_accessor.
    #   But this time, instead of dynamically creating an instance
    #   variable, store everything in the #attributes hash.
    # # NB: it's important that the user of SQLObject call finalize!
    # at the end of their subclass definition, otherwise the
    # getter/setter methods don't get defined. That's hacky, but it will
    # have to do. :-
    # Make sure the ::columns and setter/getter specs now pass.
    self.columns.each do |col|
      define_method(col) do
        self.attributes[col]
      end
      define_method("#{col}=") do |set_to|
        self.attributes[col] = set_to
      end
    end

  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    self_string = "#{self}"
    self_string = self_string[0].downcase + self_string[1..-1]
    @table_name ||= "#{self_string}s"
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    self.parse_all(results)
  end

  def self.parse_all(results)
    all = []
    results.each do |hash|
      all << self.new(hash)
    end
    all
  end

  def self.find(id)
    row = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        id = ?
    SQL
    return nil if row.empty?
    self.new(row.first)
  end

  def initialize(params = {}) #unknown attribute 'favorite_band'
    params.each do |attr_name, value|
      raise "unknown attribute '#{attr_name}'" unless self.class.columns.include?(attr_name.to_sym)
      self.send("#{attr_name}=", value)
    end
  end

  def attributes
    @attributes ||= {}
    # columns.each do |column|
    #   result[column] = instance_variable_get("@#{column}")
    # end
    # @attributes = result
  end

  def attribute_values
    self.class.columns.map do |column|
      self.send(column)
    end
  end

  def insert
    columns = self.class.columns.drop(1)
    col_names = columns.map(&:to_s).join(", ")
    question_marks = []
    columns.size.times { question_marks << "?"}
    question_marks = question_marks.join(", ")
    att_vals = self.attribute_values
    puts columns
    p att_vals
    puts question_marks
    DBConnection.execute(<<-SQL, *att_vals.drop(1))
      INSERT INTO
        #{self.class.table_name}  (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    att_vals = self.attribute_values
    att_vals = att_vals[1..-1] + [att_vals[0]]
    set_line = self.class.columns.drop(1).map { |attr_name| "#{attr_name} = ?"}.join(", ")
    DBConnection.execute(<<-SQL, *att_vals)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = ?
    SQL
  end

  def save
    if self.id
      update
    else
      insert
    end
  end
end
