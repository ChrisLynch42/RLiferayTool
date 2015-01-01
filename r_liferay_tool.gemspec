Gem::Specification.new do |s|
  s.name        = 'RLiferayTool'
  s.version     = '0.0.4'
  s.date        = '2013-12-17'
  s.add_development_dependency 'rspec', '~> 2.14'
  s.add_development_dependency 'minitest', '~> 5.0'
  s.add_runtime_dependency 'nokogiri', '~> 1.6'
  s.add_runtime_dependency 'activesupport', '~> 3.2'
  s.add_runtime_dependency 'thor', '~> 0.17'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
  s.executables << 'r_liferay_tool'

  s.summary     = "A tool to generate opinionated code for a Liferay maven portlet-service project."
  s.description = "A tool to generate opinionated code for a Liferay maven portlet-service project.  You must be in the root folder of the Liferay Maven Portlet-Service project."
  s.authors     = ["Chris Lynch, Mike Zanchi"]
  s.email       = 'chrislynch42@yahoo.com'
  s.files       = ["lib/r_liferay_tool.rb",
                   "lib/r_liferay_lib/column.rb",
                   "lib/r_liferay_lib/prepare_portlet_service.rb",
                   "lib/r_liferay_lib/read_service.rb",
                   "lib/r_liferay_lib/xml_utility.rb",
                   "lib/r_liferay_lib/read_pom.rb",
                   "lib/r_liferay_lib/template_utility.rb",
                   "lib/r_liferay_lib/portlet_service_templates/add.jsp.erb",
                   "lib/r_liferay_lib/portlet_service_templates/liferay-plugin-package.properties.erb",
                   "lib/r_liferay_lib/portlet_service_templates/PortletController.java.erb",
                   "lib/r_liferay_lib/portlet_service_templates/edit.jsp.erb",
                   "lib/r_liferay_lib/portlet_service_templates/ListItemLocalServiceImpl.java.erb",
                   "lib/r_liferay_lib/portlet_service_templates/portlet.xml.erb",
                   "lib/r_liferay_lib/portlet_service_templates/init.jsp.erb",
                   "lib/r_liferay_lib/portlet_service_templates/ListItemServiceImpl.java.erb",
                   "lib/r_liferay_lib/portlet_service_templates/view.jsp.erb"]
  s.homepage    = 'https://github.com/ChrisLynch42/RLiferayTool'
  s.license       = 'GPL v3'
end
