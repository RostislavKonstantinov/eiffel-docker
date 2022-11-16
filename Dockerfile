FROM ubuntu:focal as lang

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        bc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


FROM lang as eiffel-builder

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Zurich

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl \
        bzip2 \
        gcc make \
        libxtst-dev \
        libgtk2.0-dev \
        libgtk-3-dev \
        libgdk-pixbuf2.0-dev \
        libc-dev \
        libssl-dev \
        wget \
        python3-pip \
        python3-venv  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install junitparser
RUN curl -o /tmp/eiffel_install.sh -sSL https://www.eiffel.org/setup/install.sh \
 && bash -- /tmp/eiffel_install.sh --url https://ftp.eiffel.com/pub/beta/22.05/Eiffel_22.05_rev_106302-linux-x86-64.tar.bz2 --install-dir /usr/local/eiffel \
 && rm -f /tmp/eiffel_install.sh

# Define Eiffel environment variables
ENV ISE_EIFFEL=/usr/local/eiffel \
    ISE_PLATFORM=linux-x86-64
ENV ISE_LIBRARY=$ISE_EIFFEL \
    PATH=$PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/library/gobo/spec/$ISE_PLATFORM/bin:$ISE_EIFFEL/esbuilder/spec/$ISE_PLATFORM/bin

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/eiffel && \
    echo "eiffel:x:${uid}:${gid}:eiffel,,,:/home/eiffel:/bin/bash" >> /etc/passwd && \
    echo "eiffel:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/eiffel

# create directory for Eiffel precompiled libraries
RUN mkdir -p /home/eiffel/.es/eiffel_user_files/22.05/precomp/spec/$ISE_PLATFORM/

COPY precomp.tar  /home/eiffel/.es/eiffel_user_files/22.05/precomp/spec/$ISE_PLATFORM/

RUN cd /home/eiffel/.es/eiffel_user_files/22.05/precomp/spec/$ISE_PLATFORM/ && \
    tar -xvf  /home/eiffel/.es/eiffel_user_files/22.05/precomp/spec/$ISE_PLATFORM/precomp.tar --strip-components=1

#RUN  ec -config $ISE_EIFFEL/precomp/spec/linux-x86-64/base-scoop-safe.ecf -precompile -c_compile
RUN iron update
RUN iron install time

ENV HOME /home/eiffel


FROM eiffel-builder

COPY examples /usercode
