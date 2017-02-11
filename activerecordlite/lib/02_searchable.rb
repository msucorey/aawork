require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)

    # I used a local variable where_line where I mapped the keys of the
    #  params to "#{key} = ?" and joined with AND.
    # To fill in the question marks, I used the values of the params
    # object.

    where_line = params.keys.map { |key| "#{key} = ?"}.join(" AND ")
    vals = params.values

    things = DBConnection.execute(<<-SQL, *vals)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{where_line}
    SQL
    return [] if things.empty?
    things.map { |thing| self.new(thing) }
  end
end

class SQLObject
  extend Searchable
end
