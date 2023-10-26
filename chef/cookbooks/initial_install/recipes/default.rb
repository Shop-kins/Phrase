# install
execute "jq_install" do
  command "sudo yum install -y jq"
  action :run
  not_if 'command -v jq'
end

execute "docker_start" do
  command "sudo systemctl start docker"
  action :nothing
end

execute "docker_install" do
  command "sudo yum install -y docker"
  action :run
  not_if 'command -v docker'
  notifies :run, 'execute[docker_start]', :delayed
end