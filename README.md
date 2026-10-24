# lebarsfa-docker-images
https://hub.docker.com/u/lebarsfa

You might want to check your current architecture with:
```bash
dpkg --print-architecture
```
For performance and accuracy, try to choose a computer architecture that matches the target architecture.

Also, ideally clean up any previous Docker images that might conflict with the build:
```bash
docker image rm -f $(docker images -q)
docker image prune -f
docker rm $(docker ps -qa --no-trunc --filter "status=exited")
docker system prune -a -f
```

Prerequisites for some images:
```bash
#sudo apt-get install qemu binfmt-support qemu-user-static
sudo apt-get install qemu-system binfmt-support qemu-user-static
sudo apt-get install qemu-system binfmt-support qemu-user
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
```

If you are on `amd64` and wants to build an image for `arm64`, you might need to first get the image like this so that the correct platform is used by default for this image:
```bash
docker pull --platform linux/arm64 arm64v8/ubuntu:resolute
```

GUI prerequisites for some images or tests:
```bash
xhost +local:$(id -un)
```

To build, use commands similar to:
```bash
cd pi/buster
docker build --progress=plain -t lebarsfa/pi:buster .
```
or
```bash
cd manylinux2014_aarch64-for-codac
docker build --platform linux/arm64 --progress=plain -t lebarsfa/manylinux2014_aarch64-for-codac .
```

To debug build issues, use commands similar to:
```bash
docker run --net=host -e DISPLAY -it -v "$PWD/..:$PWD/.." lebarsfa/pi:buster /bin/bash
```
or
```bash
docker run --platform linux/arm64 --net=host -e DISPLAY -it -v "$PWD/..:$PWD/.." lebarsfa/manylinux2014_aarch64-for-codac /bin/bash
```

To publish an image to Docker Hub, use commands similar to:
```bash
# Warning: docker login might require at least an empty ~/.docker/config.json...?
docker login
#docker login -u lebarsfa
docker push lebarsfa/pi:buster
#docker tag lebarsfa/pi:buster lebarsfa/pi:latest
docker logout
```
