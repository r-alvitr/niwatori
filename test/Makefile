build:
	sudo docker build . -t niwatori-test

pbuild:
	sudo docker build . -t niwatori-test --build-arg http_proxy=http://172.20.20.104:8080 --build-arg https_proxy=http://172.20.20.104:8080

run:
	sudo docker run -it --name niwatori-test niwatori-test /bin/bash

kill:
	sudo docker container prune && sudo docker image prune
