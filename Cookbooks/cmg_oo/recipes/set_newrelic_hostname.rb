#
# Cookbook Name:: cmg_core
# Recipe:: set_newrelic_hostname
#

rightscale_marker :begin

nr_host = "#{node['newrelic']['server_monitoring']['deployment_prefix']} #{node['newrelic']['server_monitoring']['hostname']}"
my_host = node['hostname']

file "/root/jq" do
    action :delete
end

bash "get_jq" do
    cwd "/root"
    code <<-EOH
        wget http://devops.carbonmedia.net/jq
    EOH
end

file "/root/jq" do
    mode '0755'
    action :create
end

bash "set_server_name" do
    cwd "/root"
    code <<-EOH
        nr_server_id=$( \
            curl \
            -X GET 'https://api.newrelic.com/v2/servers.json' \
            -H 'X-Api-Key:71eceae3fcf2bfc4321bdc9881d65a0b4f9c92052a3334e' \
            -d "filter[host]=#{my_host}" \
            | /root/jq .servers[0].id \
        )
        echo #{my_host} - #{nr_host}
        curl -X PUT "https://api.newrelic.com/v2/servers/$nr_server_id.json" \
             -H 'X-Api-Key:71eceae3fcf2bfc4321bdc9881d65a0b4f9c92052a3334e' \
             -H 'Content-Type: application/json' \
             -d \
        '{
          "server": {
            "name": "#{nr_host}"
          }
        }' 
    EOH
end

rightscale_marker :end
