require 'nokogiri'

module RLiferayTool
  class XMLUtility
    attr_reader :xml_file_location, :xml_content, :namespaces

    def initialize(xml_file_location)
      self.xml_file_location=xml_file_location
      read_xml_content()
    end

    def read_xml_content()
      f = nil
      begin
        f = File.open(xml_file_location)
        self.xml_content = Nokogiri::XML(f)
        self.namespaces = self.xml_content.collect_namespaces
        xml_content.remove_namespaces!
      ensure
        f.close()
      end
    end

    def write_xml_content()
      f = nil
      begin
        f = File.new(self.xml_file_location,"w")
        add_namespaces
        f.write(xml_content.to_s)
      ensure
        f.close()
      end
    end




    private
    attr_writer :xml_file_location, :xml_content, :namespaces

    def add_namespaces
      self.namespaces.each { | key, value|
        xml_content.add_namespace_definition(key,value)
      }
    end


  end
end