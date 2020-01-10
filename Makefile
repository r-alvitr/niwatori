NAME:=niwatori-jdk

build:
	sudo docker build . -t ${NAME}

pbuild:
	sudo docker build . -t ${NAME} --build-arg http_proxy=http://172.20.20.104:8080 --build-arg https_proxy=http://172.20.20.104:8080

run:
	sudo docker run -it --name niwatori -p '5901:5901' niwatori /bin/bash

kill:
	sudo docker container prune && sudo docker image prune
