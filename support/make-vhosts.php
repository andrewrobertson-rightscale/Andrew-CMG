<?php

$cfg = array(
	'base_vhost_index' 	=> 10,
	'base_recipe_name'	=> 'vhost_',
	'port'				=> 8000
);

$vhost_index = $cfg['base_vhost_index'];

$subdomains = array(
	'www' => '/home/vhosts/@@site@@'
);

$sites = array(
	'indianasportsman.com' => array(
		'hoosierhunting.net',
		'indianahuntingforum.com',
		'indianamasteranglers.com',
		'indianaoutdoorsman.com'
	)
);

$recipe_template = <<< EOF
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

template "/etc/httpd/sites-available/@@vhost_filename@@" do
  source "@@vhost_conf_file@@"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

link "/etc/httpd/sites-available/@@vhost_filename@@" do
    to "/etc/httpd/sites-enabled/@@vhost_filename@@"
end

bash "restart_httpd" do
  code <<-EOF
  	service httpd restart
  EOF
end

rightscale_marker :end
EOF;

$conf_template = <<< EOF
<VirtualHost *:@@port@@>
  ServerName @@vhost_domain_name@@
  ServerAlias @@vhost_aliases@@
  DocumentRoot @@docroot@@
  <DirectoryMatch  /\.git/|/\.svn/ >
    Deny from all
  </DirectoryMatch>

  <Directory @@docroot@@>
    Options FollowSymLinks
    AllowOverride All
    Order allow,deny
    Allow from all
  </Directory>

  RewriteEngine On
  # Uncomment for rewrite debugging
  #RewriteLog /var/log/httpd/http_rewrite_log
  #RewriteLogLevel 9

  # Include Rewrite rules from server config for maintenance mode.
  # Rewrite rules are not inherited in VirtualHost Directive, so must
  # explicitly include it here.
  Include conf.d/maintenance.conf

  # Enable status page for monitoring purposes
  RewriteCond %{REMOTE_ADDR} ^(127.0.0.1)
  RewriteRule ^(/server-status) $1 [H=server-status,L]

  # Setup the logs in the appropriate directory
  CustomLog /var/log/httpd/access_log combined
  ErrorLog  /var/log/httpd/error_log
  LogLevel warn

  # Deflate
  AddOutputFilterByType DEFLATE text/html text/plain text/xml application/xml application/xhtml+xml text/javascript text/css application/x-javascript
  BrowserMatch ^Mozilla/4 gzip-only-text/html
  BrowserMatch ^Mozilla/4\.0[678] no-gzip
  BrowserMatch \bMSIE !no-gzip !gzip-only-text/html

</VirtualHost>
EOF;

$metadata_template = <<< EOF
recipe "cmg_oo::@@recipe_name@@", "Sets up the @@vhost_domain_name@@ vhost(s) and alias(es)."
EOF;

foreach($sites as $site => $aliases) {
	if (is_array($sites[$site])) {
		create_vhost($site, $aliases);
	} else {
		create_vhost($site);
	}
}

function create_vhost($domain, $aliases = null) {
	global 
		$subdomains, 
		$vhost_index, 
		$cfg, 
		$recipe_template,
		$conf_template,
		$metadata_template;

	$site_name = $site = $domain;
	
	//add subdomains
	foreach($subdomains as $subdomain => $docroot) {
		$docroot = str_replace('@@site@@', $site_name, $docroot);
		if (!empty($subdomain)) {
			$site = "{$subdomain}.{$site_name}";
		}
		if (!is_null($aliases)) {
			foreach($aliases as $idx => $alias) {
				array_push($aliases, "{$subdomain}.{$alias}");
			}
		}
	}
	array_unshift($aliases, $domain);
	echo "{$domain}\n";
	$sitename_underscore = str_replace('.', '_', $domain);
	$find = array(
		'@@recipe_name@@',
		'@@docroot@@',
		'@@port@@',
		'@@vhost_filename@@',
		'@@vhost_domain_name@@',
		'@@site@@',
		'@@vhost_aliases@@',
		'@@vhost_conf_file@@'
	);
	$replace = array(
		'vhost_' . $sitename_underscore,
		$docroot,
		$cfg['port'],
		"{$vhost_index}-{$site}",
		$site,
		$site,
		implode(' ', $aliases),
		"{$replace[0]}.conf.erb"
	);
	$recipe_tmp = str_replace($find, $replace, $recipe_template);
	$conf_tmp = str_replace($find, $replace, $conf_template);
	$metadata_tmp = str_replace($find, $replace, $metadata_template);
	create_file("{$replace[0]}.rb", $recipe_tmp);
	create_file("{$replace[0]}.conf.erb", $conf_tmp);
	append_file("metadata.rb", $metadata_tmp);
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