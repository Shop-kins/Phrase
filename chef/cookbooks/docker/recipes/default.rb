# install

check_docker_swarm = `docker info --format '{{.Swarm.ControlAvailable}}'`

execute "docker_swarm" do
  command "docker swarm init"
  action :run
  not_if { check_docker_swarm != 'true' }
  notifies :run, 'execute[docker_registry]', :delayed
end

execute "docker_registry" do
  command "docker service create --name registry --publish published=5000,target=5000 registry:2"
  action :nothing
end

cookbook_file '/etc/docker-compose.yml' do
  source 'docker-compose_phrase.yml'
  owner 'root'
  group 'root'
  mode 0640
  action :create
  notifies :create, 'cookbook_file[/etc/Dockerfile]', :delayed
end

cookbook_file '/etc/Dockerfile' do
  source 'Dockerfile'
  owner 'root'
  group 'root'
  mode 0640
  action :create
end

remote_directory '/etc/application' do
  source 'application'
  files_owner 'root'
  files_group 'root'
  files_mode 0640
  action :create
  recursive true
end

execute 'docker_compose_build' do
  command "docker compose build"
  cwd "/etc"
  action :run
  notifies :run, 'execute[docker_compose_push]', :delayed
end

execute 'docker_compose_push' do
  command "docker compose push"
  cwd "/etc"
  action :nothing
  notifies :run, 'execute[docker_stack_deploy]', :delayed
end

execute "docker_stack_deploy" do
  command "docker stack deploy --compose-file /etc/docker-compose.yml phrase_stack"
  action :nothing
end