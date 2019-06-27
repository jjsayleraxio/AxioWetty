FROM debian:8

LABEL maintainer="Joseph Sayler <josephs@axioresearch.com>" version="1.0"

RUN apt install -y curl && curl -sL https://deb.nodesource.com/setup_10.x | bash - && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt upgrade -y && apt install -y vim tmux git ssh-client git-doc make diffutils-doc ed gettext-base python python3 python3-pip software-properties-common gcc g++ make nodejs yarn zsh zsh-common zsh-doc
RUN git clone https://github.com/krishnasrinivas/wetty.git && cd wetty && yarn && yarn build && yarn upgrade caniuse-lite browserslist
RUN curl --raw "https://raw.githubusercontent.com/jjsayleraxio/AxioWetty/master/scripts/add_user.sh" > /add_user.sh && sh /add_user.sh

WORKDIR /wetty

EXPOSE 3000

ENTRYPOINT ["node"]
CMD ["index.js", "-b", "/", "-c", "login"]
