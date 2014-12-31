RLiferayTool
============
Utility to speed up Liferay development.  This tool is for use in a Liferay project generated from maven.  It generates code in Liferay project to encourage consistent design.  While the tool works it is still in the Alpha stage of development.

The current version of the tool only supports Maven plugin 6.2.10.9 and the Liferay servicebuilder archetype.  Liferay Maven plugins require you to have a parent pom.  If you do not already have a parent pom you can download an example project from https://github.com/ChrisLynch42/RLiferayTool_Examples.

It only generates code to handle CRUD for a single table as defined in the service.xml.

```
Test/
├── Test-portlet
│   ├── pom.xml
│   └── src
│       └── main
│           └── webapp
│               └── WEB-INF
│                   ├── service.xml
```

<h2>How to use overview</h2>
To use this tool requires the use of Maven Liferay Plugin and RLiferayTool.
<ol>
  <li>Determine name, version, group id and package name of project</li>
  <li>Acquire a Maven parent pom</li>
  <li>Place parent pom in directory you wish to generate Liferay ServiceBuilder project</li>
  <li>Run Maven command as show below in the "Maven" section</li>
  <li>Edit the <project name>/<project name>-portlet/src/main/webapp/WEB-INF/service.xml file.</li>
  <li>Go into the <project name> directory and run "r_liferay_tool"</li>
</ol>



<h2>Install</h2>

To install RLiferayTool you will need to install Ruby and them install the "RLiferayTool" gem.  The tool has a few dependencies and those will be installed as well.

<h2>Maven</h2>

The maven command to generate a Liferay ServiceBuilder project is below.  If you download the example project you do not need to perform this step.

```
mvn archetype:generate -DarchetypeArtifactId=liferay-servicebuilder-archetype -DarchetypeGroupId=com.liferay.maven.archetypes -DarchetypeVersion=6.2.10.9 -DgroupId=com.example -DartifactId=Test -Dversion=1.00.000 -DpackageName=com.example -DinteractiveMode=false
```
In this example it should create a folder called "Test" with the following structure

~~~
Test/
├── pom.xml
├── Test-portlet
└── Test-portlet-service
~~~

<h2>Service.xml</h2>

To learn how to define entities in a service.xml file go to the Liferay Developer documentation.  http://www.liferay.com/documentation/liferay-portal/6.2/development/-/ai/define-your-object-relational-map-liferay-portal-6-2-dev-guide-04--1


<h2>Run</h2>

Move into the Test directory and run the "r_liferay_tool" command.

<h2>What just happened?</h2>

The tool reads the pom file of the Maven project along with the service.xml file and generates code to Display information from the entity/table and CRUD functionality.  If the files already exist it will backup the existing file.

