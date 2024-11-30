## devel

```bash 

docker build --target=builder -t test/emacs-devel .
```

```bash

docker run --rm -it test/emacs-devel bash

```

## push

```bash
docker login

```

```bash
docker rmi okimatsuraa/emacs-with-xwidget:29.1
docker tag my/emacs okimatsuraa/emacs-with-xwidget:29.1
docker push okimatsuraa/emacs-with-xwidget:29.1
```
