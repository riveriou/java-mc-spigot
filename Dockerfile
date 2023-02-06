FROM openjdk:19-jdk-slim-buster
MAINTAINER River Riou

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/Asia/Taipei /etc/localtime && echo Asia/Taipei > /etc/timezone

RUN apt-get update  --fix-missing

# curl is needed to download the xampp installer, net-tools provides netstat command for xampp
RUN apt-get -y install vim wget
RUN apt-get clean

WORKDIR /data

RUN cd /data
RUN wget https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar

RUN echo "set pastetoggle=<F11> " >> ~/.vimrc

RUN echo 'eula=true' >> /data/eula.txt

EXPOSE  25565

ENV JAVA_MK "java -Xmx2048M -Xms1024M -jar /data/server.jar"
ENV INIT_MK "/bin/bash"

ENV INIT "/bin/bash"

ENTRYPOINT ["/bin/bash","-c"]
CMD ["$INIT"]
