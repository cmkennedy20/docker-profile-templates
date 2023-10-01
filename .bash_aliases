# rmi => pass any keyword for a container and this will remove all images which match the input
alias rmi='docker_rmi $1'
# logs => pass any keyword from a container and this will tail the log stream from that container (CTRL + C to exits)
alias logs='docker_logs $1'
# grab => pass any keyword from a container and this will return the container id based on the input string
alias grab='grab_container $1'
# igrab => pass any keyword from an image and this will return the image id based on the input string
alias igrab='grab_image $1'
# dup => pass the docker compose file name and this will rebuild(if build is specified) and deploy all services in that compose file 
alias dup='compose_up $1'
# ddown => pass the docker compose file name and this will
alias ddown='compose_down $1'
# dex => pass any keyword from a container and this will execute a bash script inside of a container
alias dex='docker_exec $1'
# dexs => pass any keyword from a container and this will execute a shell script inside of a container 
alias dexs='docker_execs $1'
# dgo => pass two arguments, the first is the docker compose name and the second is any keyword for the desired container and this will deploy a compose file and execute a bash script inside of the container
alias dgo='docker_go $1 $2'
# drun => pass any keyword from an image and this will deploy an image with the entrypoint being a bash script 
alias drun='run_container $1'
# druns => pass any keyword from an image and this will deploy an image with the entrypoint being a shell script
alias druns='run_containers $1'
# up => run this to update and upgrade all packages on a debian based system
alias up='sudo apt-get update; sudo apt-get upgrade -y;'
# ds => run ds to list all running containers on the current docker daemon
alias ds='docker ps'
# dk => pass any keyword from a container and this will kill the running container
alias dk='docker_kill $1'
# di => run di to list all images on the current docker daemon
alias di='docker images'
# cwd => run cwd to list the current working directory (similar to pwd) but it will escape all sensetive characeters in Linux
alias cwd='printf "%q\n" "$(pwd)"'
# dcp => docker container prune shorthand
alias dcp='docker container prune'
# dip => docker image prune shorthand
alias dip='docker image prune'
# dvp => docker image prune shorthand
alias dvp='docker volume prune'
# dprune => shorthand to purge all hanging resources in docker
alias dprune='docker container prune -f; docker image prune -f; docker volume prune -f; docker system prune -f'
function docker_kill()
{
 output=$(grab_container $1)
 docker kill $output
}

function docker_rmi(){
 output=$(grab_image $1)
 docker rmi $output
}

function docker_prune(){
  docker container prune --force
  docker image prune --force
  docker volume prune --force
}

function docker_logs()
{
 output=$(grab_container $1)
 docker logs -f $output
}

function grab_container(){
 docker ps | grep $1 | cut -f 1 -d " ";
}

function grab_image(){
 docker images | grep $1 | awk -F " "  '{print $3}';
}

function run_container(){
 output=$(grab_image $1)
 docker run --entrypoint=/bin/bash -it $output
}

function run_containers(){
 output=$(grab_image $1)
 docker run --entrypoint=/bin/sh -it $output
}

function compose_up(){
 docker compose -f $1 up -d --build
}

function compose_down(){
 docker compose -f $1 down
}

function docker_exec(){
 docker exec -it $(grab $1) bash
}

function docker_execs(){
 docker exec -it $(grab $1) sh
}

function docker_go(){
 compose_up $1
 docker_exec $2
}