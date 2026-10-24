# env lists environment variables
Set-Alias -Name env -Value Get-Env
# rmi => pass any keyword for a container and this will remove all images which match the input
Set-Alias rmi docker_rmi
# logs => pass any keyword from a container and this will tail the log stream from that container (CTRL + C to exits)
Set-Alias logs docker_logs
# grab => pass any keyword from a container and this will return the container id based on the input string
Set-Alias grab grab_container
# igrab => pass any keyword from an image and this will return the image id based on the input string
Set-Alias igrab grab_image
# dup => pass the docker compose file name and this will rebuild(if build is specified) and deploy all services in that compose file 
Set-Alias dup compose_up
# ddown => pass the docker compose file name and this will
Set-Alias ddown compose_down
# dex => pass any keyword from a container and this will execute a bash script inside of a container
Set-Alias dex docker_exec
# dexs => pass any keyword from a container and this will execute a shell script inside of a container 
Set-Alias dexs docker_execs
# dgo => pass two arguments, the first is the docker compose name and the second is any keyword for the desired container and this will deploy a compose file and execute a bash script inside of the container
Set-Alias dgo docker_go
# drun => pass any keyword from an image and this will deploy an image with the entrypoint being a bash script 
Set-Alias drun run_container
# druns => pass any keyword from an image and this will deploy an image with the entrypoint being a shell script
Set-Alias druns run_containers
# ds => run ds to list all running containers on the current docker daemon
Set-Alias ds docker_ps
# dk => pass any keyword from a container and this will kill the running container
Set-Alias dk docker_kill
# di => run di to list all images on the current docker daemon
Set-Alias di docker_images
# dcp => docker container prune shorthand
Set-Alias dcp docker_container_prune
# dip => docker image prune shorthand
Set-Alias dip docker_image_prune
# dvp => docker image prune shorthand
Set-Alias dvp docker_volume_prune
# dprune => shorthand to purge all hanging resources in docker
Set-Alias dprune docker_prune

function docker_prune {
    docker_container_prune
    docker_volume_prune
    docker_image_prune
    docker system prune -f;
}

function docker_image_prune{
    docker image prune -f;
}
function docker_volume_prune{
    docker volume prune -f;
}
function docker_container_prune{
    docker container prune -f;
}

function docker_ps {
    docker ps;
}
function docker_images {
    docker images;
}

function docker_kill {
    $output = grab_container $args[0]
    docker kill $output
}

function docker_rmi {
    $output = grab_image $args[0]
    docker rmi $output
}

function docker_logs {
    $output = grab_container $args[0]
    docker logs -f $output
}

function grab_container {
    docker ps | Select-String -Pattern $args[0] | ForEach-Object { $_.ToString().Split()[0] }
}

function grab_image {
    docker images | Select-String -Pattern $args[0] | ForEach-Object { $_ -split " +", 5 | Select-Object -Index 2 }
}

function run_container {
    $output = grab_image $args[0]
    docker run --entrypoint=/bin/bash -it $output
}

function run_containers {
    $output = grab_image $args[0]
    docker run --entrypoint=/bin/sh -it $output
}

function compose_up {
    docker compose -f $args[0] up -d --build
}

function compose_down {
    docker compose -f $args[0] down
}

function docker_exec {
    $output = grab $args[0]
    docker exec -it $output bash
}

function docker_execs {
    $output = grab $args[0]
    docker exec -it $output sh
}

function docker_go {
    compose_up $args[0]
    docker_exec $args[1]
}

Function Get-Env{
  Get-ChildItem Env:
}
