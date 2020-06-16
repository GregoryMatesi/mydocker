FROM rocker/r-ver:3.4.4

RUN apt-get update -y && apt-get install -y \
    wget \
    git \
    unzip \
    python3
    
RUN mkdir /home/test

RUN wget https://mathgen.stats.ox.ac.uk/genetics_software/shapeit/shapeit.v2.r904.glibcv2.12.linux.tar.gz

RUN tar -zxvf shapeit.v2.r904.glibcv2.12.linux.tar.gz

RUN mv shapeit.v2.904.2.6.32-696.18.7.el6.x86_64/bin/shapeit /usr/local/bin

RUN wget https://www.dropbox.com/s/cmq4saduh9gozi9/RFMix_v1.5.4.zip

RUN unzip RFMix_v1.5.4.zip

RUN mv RFMix_v1.5.4 /usr/local/bin

RUN wget http://dalexander.github.io/admixture/binaries/admixture_linux-1.3.0.tar.gz

RUN tar -zxvf admixture_linux-1.3.0.tar.gz

RUN mv /dist/admixture_linux-1.3.0 /usr/local/bin

