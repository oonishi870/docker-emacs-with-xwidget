# docker-emacs-with-xwidget

```bash

docker build -t my/emacs .
```

```bash
xhost +
docker run -it --rm --name emacs-test   \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v /tmp/.XIM-unix:/tmp/.XIM-unix \
       -v /home:/home                   \
       -e HOME=$HOME                    \
       -e DISPLAY=$DISPLAY              \
       -e GTK_IM_MODULE=$GTK_IM_MODULE  \
       -e QT_IM_MODULE=$QT_IM_MODULE    \
       -e LANG=C.UTF-8                  \
       -e LANGUAGE=en_US:               \
       -e XMODIFIERS=$XMODIFIERS        \
       -v /etc/passwd:/etc/passwd:ro    \
       -v /etc/group:/etc/group:ro      \
       -v /etc/shadow:/etc/shadow:ro    \
       --workdir=$(pwd)                 \
       --network=host                   \
       --user $(id -u):$(id -g)         \
       my/emacs
```


