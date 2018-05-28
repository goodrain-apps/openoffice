# Dockerized OpenOffice(v4.1.5)

![](screenshots/openoffice_and_docker.png)

## Build

Prepare Windows fonts.
Just like: Fonts.tar.gz

```
docker build -t goodrainapps/openoffice:v4.1.5 .
```

## Usage

```bash
docker run -d -p 6080:6080 -p 8100:8100 --name openoffice  goodrainapps/openoffice:v4.1.5
```

## Goodrain Apps

[OpenOffice](https://www.goodrain.com/app/detail/141)

## Reference

* <https://github.com/tobegit3hub/dockerized-openoffice>
* <https://www.openoffice.org/>
* <https://github.com/zhouzhi2468/openoffice>
