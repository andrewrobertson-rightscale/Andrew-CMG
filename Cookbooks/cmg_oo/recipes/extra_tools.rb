#
# Cookbook Name:: cmg_oo
# Recipe:: extra_tools
#

rightscale_marker :begin

yum_package "htop" do
  action :install
end

yum_package "mc" do
  action :install
end

yum_package "ncdu" do
  action :install
end

rightscale_marker :end
