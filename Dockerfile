FROM rocker/r-ver:3.4.4

RUN apt-get update -y && apt-get install -y \
    wget \
    git \
    python3
    
RUN mkdir /home/test

RUN wget https://mathgen.stats.ox.ac.uk/genetics_software/shapeit/shapeit.v2.r904.glibcv2.12.linux.tar.gz


