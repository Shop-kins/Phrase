# install
execute "jq_install" do
  command "sudo yum install jq"
  action :run
  not_if 'jq --version'
end