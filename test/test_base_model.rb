class TestBaseModel
  attr_accessor :column_values

  def initialize
    @column_values = {}
  end

  def read_attribute(column_name)
    @column_values[column_name.to_sym]
  end

  def write_attribute(column_name, value)
    @column_values[column_name.to_sym] = value
  end

  def self.where(options = {})
    @@where_options = options
  end

  def self.where_options
    @@where_options
  end
end
