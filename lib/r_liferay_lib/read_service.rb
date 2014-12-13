require_relative 'column'
require_relative 'xml_utility'

module RLiferayLib
  class ReadService
    attr_reader :service_xml_file, :entities

    def initialize(service_xml_file)
      self.service_xml_file=service_xml_file
      self.entities = Hash.new()
      read_xml
    end



    private
    attr_writer :service_xml_file, :entities

    def read_xml
      xml_utility = XMLUtility.new(self.service_xml_file)
      entity_nodes = xml_utility.xml_content.xpath('/service-builder/entity')

      entity_nodes.each { | entity_node |
        entity_name = entity_node.attr('name')
        self.entities[entity_name] = Hash.new()
        self.entities[entity_name]['name'] = entity_name
        self.entities[entity_name]['primary_key'] = ''
        self.entities[entity_name]['columns'] = Hash.new()
        read_columns(entity_name, entity_node)
      }
    end

    def read_columns(entity_name, entity_node)
      column_nodes = entity_node.xpath('./column')
      column_nodes.each { | column_node|
        column_name = column_node.attr('name')
        if column_node.attr("primary") == 'true'
          self.entities[entity_name]['primary_key'] = column_name
        elsif !IGNORE_COLUMNS.include?(column_name)
          self.entities[entity_name]['columns'][column_name] = Column.new(column_name, column_node.attr('type'))
        end
      }
    end

    IGNORE_COLUMNS = {
        'groupId' => 'long',
        'companyId' => 'long',
        'userId' => 'long',
        'userName' => 'String',
        'createDate' => 'Date',
        'modifiedDate' => 'Date'
    }


  end
end