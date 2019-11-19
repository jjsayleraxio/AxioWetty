<img align="right" src="https://raw.githubusercontent.com/jjsayleraxio/AxioShiny/master/images/axio-logo.png">
<br>

# AxioWetty
![GitHub release (latest by date)](https://img.shields.io/github/v/release/jjsayleraxio/AxioWetty?logo=github&style=flat)
[![GitHub issues](https://img.shields.io/github/issues/jjsayleraxio/AxioWetty?logo=github&style=flat)](https://github.com/jjsayleraxio/AxioWetty/issues)
![Docker Build Status](https://img.shields.io/docker/build/jjsaxio/axio_wetty?logo=docker&style=flat)

web terminal container used by Axio Research
## How To Use:
Run the following line of code in a terminal:
```
docker run -dit --init --name=[NAME] --hostname=[HOSTNAME] -p [PORT]:3000 -p [PORT:][8050,10000-10500] -v [HOST]:[CONTAINER] jjsaxio/axio_wetty:dev
```

Code Breakdown:

* ```--init``` is required. Starts an init process. This is very important or your container will never close any processes and become overrun with orphan processes.
* ```--name=[NAME]``` is optional. Gives container a name
* ```--hostname=[HOSTNAME]``` is optional. Gives container a friendly hostname that is seen when logging into the weTTY
* ```-p [PORT]:3000``` is required. This port enables outside access to the weTTY.
* ```-p [PORT]:[8050,10000-10500]```: these are optional ports exposed in the Dockerfile. Add as many of these as necessary, following same convention, for example: ```-p [PORT]:8050 -p [PORT]:10000```, etc. These are meant to be used for web development. These same ports are also accessable between containers on the same virtual network without having to use ```-p```.
* ```-v [HOST]:[CONTAINER]``` is also optional. This binds a volumne (folder) on host with a folder on container. You can have as many of these as needed.

#### Build Notes

* https://linuxize.com/post/how-to-install-node-js-on-ubuntu-18.04/ (_alternate way to instalal node_)
* https://linuxize.com/post/how-to-install-yarn-on-ubuntu-18-04/ (_install yarn on ubuntu_)
* https://askubuntu.com/questions/872933/how-to-fix-hash-sum-mismatch-error-on-fresh-docker-image-update (_see last answer_)
* https://community.plot.ly/t/running-dash-app-in-docker-container/16067/2 (_for running dash apps in container_)
* https://docs.docker.com/config/containers/multi-service_container/ (_covers init process when running containers_)