function sandbox_is_not_running {
  ! docker ps | grep $IMAGE
}

function sandbox_does_not_exist {
  ! docker ps -a | grep $CONTAINER_NAME
}
