FROM debian:stretch

RUN apt-get update && apt-get install -y easy-rsa

RUN make-cadir /root/ca
#&& cd ~/ca

WORKDIR /root/ca

RUN ln -s openssl-1.0.0.cnf openssl.cnf

ADD bin/ /usr/local/bin
RUN chmod a+x /usr/local/bin/*
