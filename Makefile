all: build run
build:
	@docker build -t goodrainapps/openoffice:v4.1.5-en .

run:
	@docker run -d -p 6080:6080 -p 8100:8100 --name openoffice  goodrainapps/openoffice:v4.1.5-en

push:
	@docker push goodrainapps/openoffice:v4.1.5-en