FROM ubuntu:18.04

LABEL maintainer="Joseph Sayler <josephs@axioresearch.com>" version="1.2"

RUN rm -rf /etc/apt/sources.list \
	&& echo "deb mirror://mirrors.ubuntu.com/mirrors.txt disco main restricted universe multiverse" >> /etc/apt/sources.list \
	&& echo "deb mirror://mirrors.ubuntu.com/mirrors.txt disco-updates main restricted universe multiverse" >> /etc/apt/sources.list \
	&& echo "deb-src mirror://mirrors.ubuntu.com/mirrors.txt disco-updates main restricted universe multiverse" >> /etc/apt/sources.list \
	&& echo "deb mirror://mirrors.ubuntu.com/mirrors.txt disco-backports main restricted universe multiverse" >> /etc/apt/sources.list \
	&& echo "deb mirror://mirrors.ubuntu.com/mirrors.txt disco-security main restricted universe multiverse" >> /etc/apt/sources.list \
	&& apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' \
	&& add-apt-repository 'deb http://cloud.r-project.org/bin/linux/debian jessie-cran35/' \
	&& apt update \
	&& apt upgrade -y \
	&& apt install -y curl vim tmux git ssh-client build-essential make ed python3 python3-pip python3-venv software-properties-common gcc g++ nodejs npm zip unzip wget dirmngr software-properties-common apt-transport-https default-jdk curl openssl xml2 libcurl4-gnutls-dev r-base \
	&& curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
	&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
	&& apt update \
	&& apt install -y yarn \
	&& python3 -m pip install -U pip wheel \
	&& pip3 install dash pandas \
	&& git clone https://github.com/krishnasrinivas/wetty.git \
	&& cd wetty \
	&& yarn \
	&& yarn build \
	&& yarn upgrade caniuse-lite browserslist

WORKDIR /wetty

EXPOSE 3000, 8050, 10000-10500

ENTRYPOINT ["node"]
CMD ["index.js", "--base", "/", "--command", "login", "--title", "AxioWeTTY"]

