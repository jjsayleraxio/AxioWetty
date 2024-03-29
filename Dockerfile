FROM ubuntu:18.04

LABEL maintainer="Joseph Sayler <josephs@axioresearch.com>" version="1.1"

RUN rm -rf /etc/apt/sources.list \
	&& echo "deb mirror://mirrors.ubuntu.com/mirrors.txt disco main restricted universe multiverse" >> /etc/apt/sources.list \
	&& echo "deb mirror://mirrors.ubuntu.com/mirrors.txt disco-updates main restricted universe multiverse" >> /etc/apt/sources.list \
	&& echo "deb-src mirror://mirrors.ubuntu.com/mirrors.txt disco-updates main restricted universe multiverse" >> /etc/apt/sources.list \
	&& echo "deb mirror://mirrors.ubuntu.com/mirrors.txt disco-backports main restricted universe multiverse" >> /etc/apt/sources.list \
	&& echo "deb mirror://mirrors.ubuntu.com/mirrors.txt disco-security main restricted universe multiverse" >> /etc/apt/sources.list \
	&& apt update \
	&& apt upgrade -y \
	&& apt install -y curl vim tmux git ssh-client build-essential make ed python3 python3-pip python3-venv software-properties-common gcc g++ nodejs npm zip unzip wget \
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

EXPOSE 3000
EXPOSE 8050

ENTRYPOINT ["node"]
CMD ["index.js", "--base", "/", "--command", "login", "--title", "AxioWeTTY"]
