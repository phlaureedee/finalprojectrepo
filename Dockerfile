FROM iamdevopstrainer/tomcat:base
COPY /var/lib/jenkins/workspace/docker container/target/ABCtechnologies-1.0.war /usr/local/tomcat/webapps/
CMD ["catalina.sh", "run"]
