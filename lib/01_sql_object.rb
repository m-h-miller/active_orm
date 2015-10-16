require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns

    columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        "#{self.table_name}"
    SQL

    columns = columns.first.map(&:to_sym)

  end

  def self.finalize!
    self.columns.each do |col|

      define_method(col) do
        attributes[col]
      end

      define_method("#{col}=") do |value|
        attributes[col] = value
      end

    end
  end

  def self.table_name=(value)
    @table_name = value
  end

  def self.table_name
    @table_name ||= "#{self}".tableize
  end

  def self.all
    table = self.table_name

    results = DBConnection.execute(<<-SQL)
      SELECT
        #{table}.*
      FROM
        #{table}
    SQL

    results = parse_all(results)
  end

  def self.parse_all(results)
    result = results.map do |hash|
      self.new(hash)
    end
    result
  end

  def self.find(id)
    table = self.table_name

    query = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table}
      WHERE
        #{table}.id = ?
    SQL

    query.empty? ? nil : self.new(query.first)
  end

  def initialize(params = {})
    params.each_pair do |attr_name, value|
      raise "unknown attribute '#{attr_name}'" unless self.class.columns.include? attr_name.to_sym
      sender = attr_name.to_s + "="
      self.send(sender, value)
    end

  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    attributes.values
  end

  def insert
    table_name = self.class.to_s.tableize
    cols = attributes.keys.join(", ")
    vals = attributes.values
    table = "#{table_name} (#{cols})"

    qs = (['?'] * vals.count).join(", ")

    DBConnection.execute(<<-SQL, vals)
      INSERT INTO
        #{table}
      VALUES
        (#{qs})
    SQL

    self.id = DBConnection.last_insert_row_id
    self
  end

  def update
    table_name = self.class.table_name
    set = attributes.keys.map { |key| "#{key} = ?"}.join(", ")
    vals = attribute_values

    DBConnection.execute(<<-SQL, *vals)
      UPDATE
        #{table_name}
      SET
        #{set}
      WHERE
        id = #{id}
    SQL

    self
  end

  def save
    id ? insert : update
  end

end
