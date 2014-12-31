RLiferayTool
============
Utility to speed up Liferay development.  This tool is for use in a Liferay project generated from maven.  It generates code in Liferay project to encourage consistent design.  While the tool works it is still in the Alpha stage of development.

The current version of the tool only supports Maven plugin 6.2.10.9 and the Liferay servicebuilder archetype.  Liferay Maven plugins require you to have a parent pom.  If you do not already have a parent pom you can download an example project from https://github.com/ChrisLynch42/RLiferayTool_Examples.

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

Move into the Test directory and run the "r_liferay_tool" command.
