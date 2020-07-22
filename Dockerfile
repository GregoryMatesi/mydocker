FROM rocker/r-ver:3.4.4

RUN apt-get update -y && apt-get install -y \
    wget \
    git \
    unzip \
    python3
    
RUN mkdir /home/test

#shapeit
RUN wget https://mathgen.stats.ox.ac.uk/genetics_software/shapeit/shapeit.v2.r904.glibcv2.12.linux.tar.gz
RUN tar -zxvf shapeit.v2.r904.glibcv2.12.linux.tar.gz
RUN mv shapeit.v2.904.2.6.32-696.18.7.el6.x86_64/bin/shapeit /usr/local/bin

# RFMix
RUN wget https://www.dropbox.com/s/cmq4saduh9gozi9/RFMix_v1.5.4.zip
RUN unzip RFMix_v1.5.4.zip
RUN mv RFMix_v1.5.4 /usr/local/bin

# admixture
RUN wget http://dalexander.github.io/admixture/binaries/admixture_linux-1.3.0.tar.gz
RUN tar -zxvf admixture_linux-1.3.0.tar.gz
RUN mv /dist/admixture_linux-1.3.0 /usr/local/bin

# Plink
RUN wget http://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20200616.zip
RUN unzip plink_linux_x86_64_20200616.zip
RUN mv plink /usr/local/bin

# install pipeline scripts
RUN mkdir /home/test/shapeit_run
COPY run_shapeit.sh /home/test/shapeit_run

USER root
RUN chmod a+x /home/test/shapeit_run/run_shapeit.sh

# USER biodocker
