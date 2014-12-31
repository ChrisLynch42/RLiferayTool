require_relative 'column'
require_relative 'xml_utility'

module RLiferayLib
  class ReadPOM
    attr_reader :pom_xml_file, :version, :package

    def initialize(pom_xml_file)
      self.pom_xml_file=pom_xml_file
      read_xml
    end



    private
    attr_writer :pom_xml_file, :version, :package

    def read_xml
      xml_utility = XMLUtility.new(self.pom_xml_file)
      self.version = xml_utility.xml_content.at_xpath('/project/version').text.to_s
      self.package = xml_utility.xml_content.at_xpath('/project/groupId').text.to_s
    end



  end
end