How to use this image Hosting some simple static content

A simple Dockerfile can be used to generate a new image that includes the necessary content.

Place Dockerfile file in the same directory as your directory of content

run, $ docker build -t some-content-sloopaweb .

then start your container.

$ docker run -dit --name mysloopa -p 9070:80 some-content-sloopaweb
