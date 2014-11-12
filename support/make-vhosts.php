<?php

$cfg = array(
	'base_vhost_index' 	=> 10,
	'base_recipe_name'	=> 'vhost_',
	'port'				=> 8000,
	'video_port'		=> 80,
	'www_server_ip'		=> '54.84.247.215',
	'video_server_ip'	=> '54.208.74.249'
);

$vhost_index = $cfg['base_vhost_index'];

$subdomains = array(
	'' 			=> '/home/vhosts/@@site@@/httpdocs',		//handles base domain vhost
	'www'		=> '/home/vhosts/@@site@@/httpdocs',		//handles www subdomain vhost
	'videos'	=> '/home/vhosts/videos/@@site@@/httpdocs'	//handles videos subdomain vhost
);

$sites = array(
	'360tuna.com',
	'airsoftsociety.com',
	'arkansashunting.net',
	'beekeepingforum.com',
	'beekeepingforums.com',
	'bersaforum.com',
	'bersaforums.com',
	'caracalforum.com',
	'caracalforums.com',
	'catfish1.com',
	'cattleforum.com',
	'cattleforums.com',
	'chickenforum.com',
	'chickenforums.com',
	'cztalk.com',
	'dairygoatinfo.com',
	'firearmstalk.com',
	'georgiahunting.org',
	'georgiapacking.org',
	'glockforum.com',
	'glockforums.com',
	'hipointfirearmsforums.com',
	'hipointfirearmsforum.com',
	'homesteadingtoday.com',
	'marlinforum.com',
	'marlinforums.com',
	'midwest-horse.com',
	'missouriwhitetails.com',
	'observedtrials.net',
	'ohiowaterfowlerforum.com',
	'ohiowaterfowlerforums.com',
	'paracordforum.com',
	'paracordforums.com',
	'pigforum.com',
	'pigforums.com',
	'preparedsociety.com',
	'rabbitdogs.net',
	'rugertalk.com',
	'springfieldforum.com',
	'springfieldforums.com',
	'steyrclub.com',
	'thegoatspot.net',
	'thektog.org',
	'theslingshotforum.com',
	'theslingshotforums.com',
	'tractorforum.com',
	'tractorforums.com',
	'twospoke.com',
	'velospace.org',
	'xdforum.com',
	'xdforums.com'
);


$recipe_template = <<< EOF
#
# Cookbook Name:: cmg_groupbuilders
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
recipe "cmg_groupbuilders::@@recipe_name@@", "Sets up the @@vhost_domain_name@@ vhost."
EOF;

for ($i=0; $i < count($sites); $i++) {
	$site_name = $site = $sites[$i];
	//add subdomains
	foreach($subdomains as $subdomain => $docroot) {
		$docroot = str_replace('@@site@@', $site_name, $docroot);
		$port = ($subdomain == 'videos') ? $cfg['video_port'] : $cfg['port'];
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
		$host_ip = ($subdomain == 'videos') ? $cfg['video_server_ip'] : $cfg['www_server_ip'];
		append_file("hosts", "{$host_ip} {$site}");
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