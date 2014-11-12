#
# Cookbook Name:: cmg_oo
# Recipe:: install_imagemagick
#

rightscale_marker :begin

yum_package "ImageMagick" do
  action :install
end

rightscale_marker :end
