FROM openjdk:19-jdk-slim-buster
MAINTAINER River Riou

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/Asia/Taipei /etc/localtime && echo Asia/Taipei > /etc/timezone
RUN apt-get update  --fix-missing

# curl is needed to download the xampp installer, net-tools provides netstat command for xampp
RUN apt-get -y install curl net-tools vim wget unzip git


WORKDIR /data
RUN cd /data
RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -jar ./BuildTools.jar --rev latest
RUN mv /data/spigot-*.jar /data/spigot.jar
RUN apt-get clean
RUN echo "set pastetoggle=<F11> " >> ~/.vimrc

RUN echo 'eula=true' >> /data/eula.txt
EXPOSE  25565

ENV JAVA_MK "java -Xmx2048M -Xms1024M -jar /data/spigot.jar"
ENV INIT_MK "/bin/bash"

ENV INIT "/bin/bash"

ENTRYPOINT ["/bin/bash","-c"]
CMD ["$INIT"]
