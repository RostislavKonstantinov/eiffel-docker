# eiffel-docker
## Build image
```bash
docker build --platform linux/amd64 -t eiffel .
```

## Run example
```bash
docker run -ti --rm eiffel bash

/usercode/script.sh 10s ec application.e /usercode/application -batch
```
See results:
```bash
cat /usercode/completed
cat /usercode/errors
```