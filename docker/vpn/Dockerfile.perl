FROM perl

ADD bin/ /usr/local/bin
RUN chmod a+x /usr/local/bin/*
