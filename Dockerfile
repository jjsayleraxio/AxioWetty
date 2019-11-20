FROM ubuntu:18.04

LABEL maintainer="Joseph Sayler <josephs@axioresearch.com>" version="1.2"

ARG DEBIAN_FRONTEND=noninteractive

RUN rm -rf /etc/apt/sources.list \
	&& ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
	&& echo "deb mirror://mirrors.ubuntu.com/mirrors.txt disco main restricted universe multiverse" >> /etc/apt/sources.list \
	&& echo "deb mirror://mirrors.ubuntu.com/mirrors.txt disco-updates main restricted universe multiverse" >> /etc/apt/sources.list \
	&& echo "deb-src mirror://mirrors.ubuntu.com/mirrors.txt disco-updates main restricted universe multiverse" >> /etc/apt/sources.list \
	&& echo "deb mirror://mirrors.ubuntu.com/mirrors.txt disco-backports main restricted universe multiverse" >> /etc/apt/sources.list \
	&& echo "deb mirror://mirrors.ubuntu.com/mirrors.txt disco-security main restricted universe multiverse" >> /etc/apt/sources.list \
	&& apt update \
	&& apt upgrade -y \
	&& apt install -y gnupg curl vim tmux git ssh-client build-essential make ed python3 python3-pip python3-venv software-properties-common gcc g++ nodejs npm zip unzip wget dirmngr software-properties-common apt-transport-https default-jdk curl openssl xml2 libcurl4-gnutls-dev direnv \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 \
	&& add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' \
	&& curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
	&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
	&& curl http://archive.ubuntu.com/ubuntu/pool/main/i/icu/libicu60_60.2-3ubuntu3_amd64.deb --output /tmp/libicu60_60.2-3ubuntu3_amd64.deb \
	&& curl http://archive.ubuntu.com/ubuntu/pool/main/r/readline/libreadline7_7.0-3_amd64.deb --output /tmp/libreadline7_7.0-3_amd64.deb \
	&& dpkg -i /tmp/libicu60_60.2-3ubuntu3_amd64.deb \
	&& dpkg -i /tmp/libreadline7_7.0-3_amd64.deb \
	&& apt update \
	&& apt install -y yarn r-base \
	&& python3 -m pip install -U pip wheel \
	&& pip3 install virtualenvwrapper \
	&& git clone https://github.com/krishnasrinivas/wetty.git \
	&& cd wetty \
	&& yarn \
	&& yarn build \
	&& yarn upgrade caniuse-lite browserslist

WORKDIR /wetty

EXPOSE 3000, 8050, 10000-10500

ENTRYPOINT ["node"]
CMD ["index.js", "--base", "/", "--command", "login", "--title", "AxioWeTTY"]

