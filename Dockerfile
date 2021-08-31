FROM openjdk:16-jdk-slim-buster
MAINTAINER River Riou

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/Asia/Taipei /etc/localtime && echo Asia/Taipei > /etc/timezone
RUN apt-get update  --fix-missing

# curl is needed to download the xampp installer, net-tools provides netstat command for xampp
RUN apt-get -y install curl net-tools vim wget unzip git


WORKDIR /data
RUN cd /data
RUN wget https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar

RUN apt-get clean
RUN echo "set pastetoggle=<F11> " >> ~/.vimrc

RUN echo 'eula=true' >> /data/eula.txt
EXPOSE  25565

ENTRYPOINT ["java","-Xmx2048M","-Xms1024M","-jar","/data/server.jar","nogui"]
CMD ["/bin/bash"]
