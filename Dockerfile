FROM jenkins/jenkins:2.346.1-jdk11

USER root

RUN apt-get update && apt-get install -y lsb-release

RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y docker-ce-cli

RUN curl -L "https://github.com/docker/compose/releases/download/2.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

USER jenkins

RUN jenkins-plugin-cli --plugins "blueocean:1.25.5 docker-workflow:1.28"


## https://stackoverflow.com/questions/38726013/jenkins-and-docker-compose
# FROM jenkins/jenkins:2.289.3-lts-jdk11  
# USER root  
# RUN apt-get update && apt-get install -y apt-transport-https \  
#        ca-certificates curl gnupg2 \  
#        software-properties-common  
# RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -  
# RUN apt-key fingerprint 0EBFCD88  
# RUN add-apt-repository \  
#        "deb [arch=amd64] https://download.docker.com/linux/debian \  
#        $(lsb_release -cs) stable"  
# RUN apt-get update && apt-get install -y docker-ce-cli  
# RUN curl -L \  
#   "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" \  
#   -o /usr/local/bin/docker-compose \  
#   && chmod +x /usr/local/bin/docker-compose  
# USER jenkins  
# RUN jenkins-plugin-cli --plugins "blueocean:1.24.7 docker-workflow:1.26"  
