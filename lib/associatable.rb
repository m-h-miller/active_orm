require_relative 'searchable'
require 'active_support/inflector'

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
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    self.foreign_key = options[:foreign_key]
    self.primary_key = options[:primary_key]
    self.class_name  = options[:class_name]

    self.foreign_key ||= "#{name}_id".to_sym
    self.primary_key ||= :id
    self.class_name  ||= name.to_s.camelcase.singularize
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    self.foreign_key = options[:foreign_key]
    self.primary_key = options[:primary_key]
    self.class_name  = options[:class_name]

    #defaults
    self.foreign_key ||= "#{self_class_name.underscore}_id".to_sym
    self.primary_key ||= :id
    self.class_name  ||= name.to_s.camelcase.singularize
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
