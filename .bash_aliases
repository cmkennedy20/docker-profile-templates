alias rmi='docker_rmi $1'
alias logs='docker_logs $1'
alias grab='grab_container $1'
alias igrab='grab_image $1'
alias dup='compose_up $1'
alias ddown='compose_down $1'
alias dex='docker_exec $1'
alias dexs='docker_execs $1'
alias dgo='docker_go $1 $2'
alias drun='run_container $1'
alias druns='run_containers $1'
alias up='sudo apt-get update; sudo apt-get upgrade -y;'
alias ds='docker ps'
alias dk='docker_kill $1'
alias di='docker images'
alias cwd='printf "%q\n" "$(pwd)"'
alias dcp='docker container prune'
alias dip='docker image prune'
alias dvp='docker volume prune'
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