# install
execute "jq_install" do
  command "sudo yum install -y jq"
  action :run
  not_if 'command -v jq'
end