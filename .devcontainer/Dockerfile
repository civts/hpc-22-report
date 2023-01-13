# FROM texlive/texlive:latest
FROM texlive/texlive@sha256:3d913ca998e023db7dd9191250240ae0a0a0cd6cd1beaa578ce5d2250153748e
#2020-11-13T23:00:23.019512792+01:00

ARG UNAME=user
ARG UID=1000
ARG GID=$UID

RUN groupadd -g $GID -o $UNAME && \
    useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
    
#Get dependencies
RUN apt-get update && \
    apt-get install inkscape -qy && \
    apt-get install python3-pip ghostscript -qy && \
    pip install Pygments && \
    apt-get autoclean -qy && \
    apt-get autoremove -qy

#Perl libraries needed for latex workshop to be able to format our tex files
RUN wget -O - http://cpanmin.us | perl - --self-upgrade && \
    cpan Try::Tiny Unicode::GCString YAML::Tiny File::HomeDir

# Not sure why we would or would not need this line.
#ENV PERL_CPANM_OPT "--from https://cpan.metacpan.org/"

USER $UNAME 
