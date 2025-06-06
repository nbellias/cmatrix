# A cmatrix clone

## Commands

docker build . -t nbellias/cmatrix
docker run --rm -it nbellias/cmatrix -a -r

docker login
docker buildx create --name buildx-multi-arch  
docker buildx use buildx-multi-arch  
docker buildx build --no-cache --platform linux/amd64,linux/arm64/v8 . -t nbellias/cmatrix --push
docker buildx build --no-cache --platform linux/386,linux/amd64,linux/arm64/v8,linux/arm/v7,linux/ppc64le,linux/s390x . -t nbellias/cmatrix --push

docker run --rm -it --platform linux/ppc64le nbellias/cmatrix -a -r

docker rmi nbellias/cmatrix

docker system prune
