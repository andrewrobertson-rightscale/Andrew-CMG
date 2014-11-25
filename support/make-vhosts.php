<?php

$cfg = array(
	'base_vhost_index' 	=> 10,
	'base_recipe_name'	=> 'vhost_',
	'port'				=> 8000
);

$vhost_index = $cfg['base_vhost_index'];

$subdomains = array(
	'' 			=> '/home/vhosts/@@site@@',		//handles base domain vhost
	'www'		=> '/home/vhosts/@@site@@'
);

$sites = array(
	'indianasportsman.com',
	'hoosierhunting.net',
	'indianahuntingforum.com',
	'indianamasteranglers.com',
	'indianaoutdoorsman.com',
);


$recipe_template = <<< EOF
#
# Cookbook Name:: cmg_oo
# Recipe:: @@recipe_name@@
#

rightscale_marker :begin

  service "apache2" do
  case node[:platform]
  when "redhat","centos","scientific","fedora","suse"
    service_name "httpd"
    # If restarted/reloaded too quickly httpd has a habit of failing.
    # This may happen with multiple recipes notifying apache to restart - like
    # during the initial bootstrap.
    restart_command "/sbin/service httpd restart && sleep 1"
    reload_command "/sbin/service httpd reload && sleep 1"
  when "debian","ubuntu"
    service_name "apache2"
    restart_command "/usr/sbin/invoke-rc.d apache2 restart && sleep 1"
    reload_command "/usr/sbin/invoke-rc.d apache2 reload && sleep 1"
  when "arch"
    service_name "httpd"
  end
  supports value_for_platform(
    "debian" => { "4.0" => [ :restart, :reload ], "default" => [ :restart, :reload, :status ] },
    "ubuntu" => { "default" => [ :restart, :reload, :status ] },
    "redhat" => { "default" => [ :restart, :reload, :status ] },
    "centos" => { "default" => [ :restart, :reload, :status ] },
    "scientific" => { "default" => [ :restart, :reload, :status ] },
    "fedora" => { "default" => [ :restart, :reload, :status ] },
    "arch" => { "default" => [ :restart, :reload, :status ] },
    "suse" => { "default" => [ :restart, :reload, :status ] },
    "default" => { "default" => [:restart, :reload ] }
  )
  action :nothing
  end

# Sets up apache PHP virtual host
  project_root = "@@docroot@@"
  php_port = @@port@@

  # Adds php port to list of ports for webserver to listen on
  # See cookbooks/app/definitions/app_add_listen_port.rb for the "app_add_listen_port" definition.
  app_add_listen_port php_port
  
  directory "@@docroot@@" do
    owner "rightscale"
    group "apache"
    mode 00755
    recursive true
    action :create
  end
  
  # Configure apache vhost for PHP
  # See https://github.com/rightscale/cookbooks/blob/master/apache2/definitions/web_app.rb for the "web_app" definition.
  web_app "@@vhost_filename@@" do
    template "app_server.erb"
    docroot project_root
    vhost_port php_port.to_s
    server_name "@@vhost_domain_name@@"
    allow_override "All"
    apache_log_dir node[:apache][:log_dir]
    cookbook "app_php"
  end

rightscale_marker :end
EOF;

$metadata_template = <<< EOF
recipe "cmg_oo::@@recipe_name@@", "Sets up the @@vhost_domain_name@@ vhost."
EOF;

for ($i=0; $i < count($sites); $i++) {
	$site_name = $site = $sites[$i];
	//add subdomains
	foreach($subdomains as $subdomain => $docroot) {
		$docroot = str_replace('@@site@@', $site_name, $docroot);
		if (!empty($subdomain)) {
			$site = "{$subdomain}.{$site_name}";
		}
		echo "{$site}\n";
		$sitename_underscore = str_replace('.', '_', $site);
		$find = array(
			'@@recipe_name@@',
			'@@docroot@@',
			'@@port@@',
			'@@vhost_filename@@',
			'@@vhost_domain_name@@',
			'@@site@@'
		);
		$replace = array(
			'vhost_' . $sitename_underscore,
			$docroot,
			$port,
			"{$vhost_index}-{$site}",
			$site,
			$site
		);
		$recipe_tmp = str_replace($find, $replace, $recipe_template);
		$metadata_tmp = str_replace($find, $replace, $metadata_template);
		create_file("{$replace[0]}.rb", $recipe_tmp);
		append_file("metadata.rb", $metadata_tmp);
	}
	append_file("metadata.rb", "");
	$vhost_index++;
}

function create_file($filename, $contents) {
	$fp = fopen($filename, 'w+');
	fwrite($fp, $contents);
	fclose($fp);
}

function append_file($filename, $contents) {
	$fp = fopen($filename, 'a+');
	fwrite($fp, $contents . "\n");
	fclose($fp);
}

?>