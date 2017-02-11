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
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # @class_name = options[:class_name] ? options[:class_name] : name.to_s.camelcase
    # @primary_key = options[:primary_key] ? options[:primary_key] : :id
    # @foreign_key = options[:foreign_key] ? options[:foreign_key] : (name.to_s + "_id").to_sym

    defaults = {class_name: name.to_s.camelcase, primary_key: :id, foreign_key: (name.to_s + "_id").to_sym}
    options = defaults.merge(options)
    @class_name = options[:class_name]
    @primary_key = options[:primary_key]
    @foreign_key = options[:foreign_key]
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # @class_name = options[:class_name] ? options[:class_name] : name.to_s.camelcase.singularize
    # @self_class_name = options[:self_class_name] ? options[:self_class_name] : self_class_name.to_s.camelcase
    # @primary_key = options[:primary_key] ? options[:primary_key] : :id
    # @foreign_key = options[:foreign_key] ? options[:foreign_key] : (self_class_name.to_s.downcase + "_id").to_sym  # ...

    defaults = {class_name: name.to_s.camelcase.singularize, self_class_name: self_class_name.to_s.camelcase,
                primary_key: :id, foreign_key: (self_class_name.to_s.downcase + "_id").to_sym}
    options = defaults.merge(options)
    @class_name = options[:class_name]
    @self_class_name = options[:self_class_name]
    @primary_key = options[:primary_key]
    @foreign_key = options[:foreign_key]
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)

    define_method(name) do
      for_key = self.send(options.foreign_key)
      options.model_class.where({options.primary_key => for_key}).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, options)

    define_method(name) do
      pri_key = self.send(options.primary_key)
      options.model_class.where({options.foreign_key => pri_key})
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  extend Associatable
end
