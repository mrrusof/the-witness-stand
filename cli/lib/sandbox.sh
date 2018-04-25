function sandbox {
  : ${TIMEOUT:=10}
  [ -v CONTAINER_NAME ] || return 1
  [ -v IMAGE ] || return 2
  timeout ${TIMEOUT}s docker run --name $CONTAINER_NAME \
                                 --hostname=localhost \
                                 --network=none \
                                 --cpus=0.8 \
                                 --rm \
                                 --interactive \
                                 $IMAGE \
                                 $@
}
