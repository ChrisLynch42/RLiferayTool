
module RLiferayLib
  class Column
    attr_reader :column_name, :column_type

    def initialize(column_name, column_type)
      self.column_name=column_name
      self.column_type=column_type
    end

    def getFormType
      FORM_TYPE_MAP[column_type]
    end

    def getJavaType
      JAVA_TYPE_MAP[column_type]
    end

    private

    attr_writer :column_name, :column_type

    FORM_TYPE_MAP = {'String' => 'text', 'int' => 'number', 'long' => 'number', 'Date' => 'date'}
    JAVA_TYPE_MAP = {'String' => 'String', 'int' => 'Integer', 'long' => 'long', 'Date' => 'date'}

  end
end