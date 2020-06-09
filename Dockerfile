FROM rocker/r-ver:3.4.4

RUN apt-get update -y && apt-get install -y \
    wget
    
RUN mkdir /home/testing

RUN wget https://github.com/odelaneau/shapeit4