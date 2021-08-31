FROM openjdk:13-jdk-slim-buster
MAINTAINER River Riou

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/Asia/Taipei /etc/localtime && echo Asia/Taipei > /etc/timezone
RUN apt-get update  --fix-missing

# curl is needed to download the xampp installer, net-tools provides netstat command for xampp
RUN apt-get -y install vim wget


WORKDIR /data
RUN cd /data
RUN wget https://launcher.mojang.com/v1/objects/4d1826eebac84847c71a77f9349cc22afd0cf0a1/server.jar

RUN apt-get clean
RUN echo "set pastetoggle=<F11> " >> ~/.vimrc

RUN echo 'eula=true' >> /data/eula.txt
EXPOSE  25565

ENV JAVA_MK "java -Xmx2048M -Xms1024M -jar /data/server.jar"
ENV INIT_MK "/bin/bash"

ENV INIT "/bin/bash"

ENTRYPOINT ["/bin/bash","-c"]
CMD ["$INIT"]
