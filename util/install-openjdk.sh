#!/bin/bash
# Remove all entries about jdk from PATH
cp ~/.profile ~/.profile_before_jdk
export PATH=`echo ${PATH} | awk -v RS=: -v ORS=: '/jdk/ {next} {print}'`
echo $PATH|grep jdk
##
echo -e "$(tput setaf 6)\u2699 Install OpenJDK 11?$(tput sgr 0)"
read -n1 -p "Choose: [y,n]" doit
echo ""
case $doit in
    y|Y) {
        sudo apt install default-jre
        #removing previous java home entries
        sed -i '/JAVA_HOME/d' ~/.profile
        echo 'export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"' | sudo tee -a ~/.profile
        echo 'export PATH="${JAVA_HOME}/bin:$PATH"' | sudo tee -a ~/.profile
        sudo ln -sfn /usr/lib/jvm/java-11-openjdk-amd64/bin/java /etc/alternatives/java
        /etc/alternatives/java -version
    }
esac
##
echo -e "$(tput setaf 6)\u2699 Install $(tput setaf 1)OpenJDK 11 DCVEM?$(tput sgr 0)?"
read -n1 -p "Choose: [y,n]" doit
echo ""
case $doit in
    y|Y) {
        sudo apt -y install openjdk-11-jre-dcevm
        sudo apt install default-jre
        #removing previous java home entries
        sed -i '/JAVA_HOME/d' ~/.profile
        echo 'export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"' | sudo tee -a ~/.profile
        echo 'export PATH="${JAVA_HOME}/bin:$PATH"' | sudo tee -a ~/.profile
        sudo ln -sfn /usr/lib/jvm/java-11-openjdk-amd64/bin/java /etc/alternatives/java
        /etc/alternatives/java -version
    }
esac
####
echo -e "$(tput setaf 6)\u2699 Install $(tput setaf 1)OpenJDK 8$(tput sgr 0)?"
read -n1 -p "Choose: [y,n]" doit
echo ""
case $doit in
    y|Y) {
        sudo apt install openjdk-8-jdk
        #removing previous java home entries
        sed -i '/JAVA_HOME/d' ~/.profile
        echo 'export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' | sudo tee -a ~/.profile
        echo 'export PATH="${JAVA_HOME}/bin:$PATH"' | sudo tee -a ~/.profile
        sudo ln -sfn /usr/lib/jvm/java-8-openjdk-amd64/bin/java /etc/alternatives/java
        # use alternative symlink to display version
        /etc/alternatives/java -version
        ##
    }
esac
##
echo -e "$(tput setaf 1)\U1F44D The JDK you seleted has been installed.$(tput sgr 0)"
echo -e "$(tput setaf 3)\u2b50 Please reset your session to update the PATH$(tput sgr 0)"