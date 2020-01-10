build:
	sudo docker build . -t terfno/niwatori-jdk

pbuild:
	sudo docker build . -t niwatori-jdk --build-arg http_proxy=http://172.20.20.104:8080 --build-arg https_proxy=http://172.20.20.104:8080

run:
	sudo docker run --name niwatori -p '5901:5901' niwatori
