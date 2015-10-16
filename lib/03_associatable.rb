require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    class_name.downcase.underscore + "s"
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @class_name = "#{name.capitalize.singularize.camelcase}"
    @primary_key = :id
    @foreign_key = (name.to_s.downcase + "_id").to_sym

    options.each_pair do |k,v|
      instance_variable_set("@#{k}", v)
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @class_name = name.singularize.capitalize
    @primary_key = :id
    @foreign_key = (self_class_name.downcase.singularize + "_id").to_sym

    options.each_pair do |k,v|
      instance_variable_set("@#{k}", v)
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, params = {})
    
  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  extend Associatable
end
