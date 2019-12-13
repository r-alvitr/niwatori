build:
	@sudo docker build . -t niwatori

run:
	@sudo docker run --name niwatori -p '5901:5901' niwatori