# install
execute "jq_install" do
  command "sudo yum install -y jq"
  action :run
  not_if 'command -v jq'
end

execute "docker_start" do
  command "sudo systemctl start docker"
  action :nothing
  notifies :run, 'execute[docker_compose_download]', :immediate
end

execute "docker_install" do
  command "sudo yum install -y docker"
  action :run
  not_if 'command -v docker'
  notifies :run, 'execute[docker_start]', :immediate
end

execute "docker_compose_download" do
  command "curl -L https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-compose-plugin-2.6.0-3.el7.x86_64.rpm -o ./compose-plugin.rpm"
  action :nothing
  notifies :run, 'execute[docker_compose_install]', :immediate
end

execute "docker_compose_install" do
  command "yum install ./compose-plugin.rpm -y"
  action :nothing
end