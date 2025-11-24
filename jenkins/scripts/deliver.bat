@echo off
REM Echo informational messages
echo The following Maven command installs your Maven-built Java application
echo into the local Maven repository, which will ultimately be stored in
echo Jenkins's local Maven repository (and the "maven-repository" Docker data
echo volume).

REM Run Maven commands with echoing commands (similar to set -x in bash)
echo Running: mvn jar:jar install:install help:evaluate -Dexpression=project.name
mvn jar:jar install:install help:evaluate -Dexpression=project.name

echo The following command extracts the value of the ^<name/^> element
echo within ^<project/^> of your Java/Maven project's "pom.xml" file.

for /f "delims=" %%a in ('mvn -q -DforceStdout help:evaluate -Dexpression=project.name') do set NAME=%%a

echo The following command extracts the value of the ^<version/^> element
echo within ^<project/^> of your Java/Maven project's "pom.xml" file.

for /f "delims=" %%a in ('mvn -q -DforceStdout help:evaluate -Dexpression=project.version') do set VERSION=%%a

echo The following command runs and outputs the execution of your Java application
echo (which Jenkins built using Maven) to the Jenkins UI.

echo Running: java -jar target\%NAME%-%VERSION%.jar
java -jar target\%NAME%-%VERSION%.jar
