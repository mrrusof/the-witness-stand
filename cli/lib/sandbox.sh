function sandbox {
  : ${TIMEOUT:=10}
  : ${TWS_DEBUG:=false}
  [ -v CONTAINER_NAME ] || return 101
  [ -v IMAGE ] || return 102
  timeout ${TIMEOUT}s docker run --name $CONTAINER_NAME \
                                 --env TWS_DEBUG \
                                 --hostname=localhost \
                                 --network=none \
                                 --cpus=0.8 \
                                 --rm \
                                 --interactive \
                                 $IMAGE \
                                 $@
}
