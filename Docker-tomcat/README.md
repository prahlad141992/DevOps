How to use this image Hosting some simple static content

A simple Dockerfile can be used to generate a new image that includes the necessary content.

Place Dockerfile file in the same directory as your directory of content

run, $ docker build -t some-content-tomcat .

then start your container.

$ docker run -dit --name mytomcat -p 9080:8080 some-content-tomcat
