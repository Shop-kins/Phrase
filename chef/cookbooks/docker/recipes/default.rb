# install

check_docker_swarm = `docker info --format '{{.Swarm.ControlAvailable}}'`

execute "docker_swarm" do
  command "docker swarm init"
  action :run
  not_if { check_docker_swarm! == 'true' }
  notifies :run, 'docker_registry', :delayed
end

execute "docker_registry" do
  command "docker service create --name registry --publish published=5000,target=5000 registry:2"
  action :nothing
end

execute "docker_compose_push" do
  command "docker compose push"
  action :run
  notifies :run, 'docker_compose_push', :delayed
end

execute "docker_compose_push" do
  command "docker compose push"
  action :nothing
end

execute "docker_stack_deploy" do
  command "docker stack deploy --compose-file docker-compose_phrase.yml phrase_stack"
  action :nothing
end