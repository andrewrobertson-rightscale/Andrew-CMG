#
# Cookbook Name:: cmg_oo
# Recipe:: install_wpcli
#

rightscale_marker :begin

bash "install_wpcli" do
  user "root"
  cwd "/root"
  code <<-EOH
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/master/utils/wp-completion.bash
	chmod +x wp-cli.phar
	mv wp-completion.bash /usr/local/bin
	mv wp-cli.phar /usr/local/bin
  EOH
end

rightscale_marker :end