RLiferayTool
============
Utility to speed up Liferay development.  This tool is for use in a Liferay project generated from maven.  It generates code in Liferay project to encourage consistent design.

The current version of the tool only supports Maven plugin 6.2.10.9 and the Liferay servicebuilder archetype. 

```
mvn archetype:generate -DarchetypeArtifactId=liferay-servicebuilder-archetype -DarchetypeGroupId=com.liferay.maven.archetypes -DarchetypeVersion=6.2.10.9 -DgroupId=com.example -DartifactId=Test -Dversion=1.00.000 -DpackageName=com.example -DinteractiveMode=false
```


