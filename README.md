# docker-0bin
Docker implementation of the 0bin by sametmax

## BUILD
`docker build -t 0bin .`

## RUN
### Without persistent data
`docker run --rm -p 8000 0bin`
### With persistent data
`docker run -d -v /path/to/persistent/pastes/dir:/root/pastes -p 80:8000 --name="container-name" 0bin`

