Set-Alias rmi docker_rmi
Set-Alias logs docker_logs
Set-Alias grab grab_container
Set-Alias igrab grab_image
Set-Alias dup compose_up
Set-Alias ddown compose_down
Set-Alias dex docker_exec
Set-Alias dexs docker_execs
Set-Alias dgo docker_go
Set-Alias drun run_container
Set-Alias druns run_containers
Set-Alias ds docker_ps
Set-Alias dk docker_kill
Set-Alias di docker_images
Set-Alias dcp docker_container_prune
Set-Alias dip docker_image_prune
Set-Alias dvp docker_volume_prune
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
