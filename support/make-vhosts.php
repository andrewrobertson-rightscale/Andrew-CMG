<?php
/**
 * make-vhosts.php
 *
 * Using an array create chef recipes, template files, and metadata.rb entries
 * to streamline the creation and support of VirtualHosts
 *
 * Script is controlled by $cfg, $subdomains, and $sites arrays
 *
 * Sites array format examples:
 *
 * $sites = array(
 * 	// basic vhost no aliases or redirects
 * 	'bar.com',
 *
 * 	//vhost with aliases and redirects
 * 	'indianasportsman.com' => array(
 * 		'aliases' => array(
 * 			'alias1',
 * 			'alias2'
 * 		),
 * 		'redirects' => array(
 * 			'hoosierhunting.net',
 * 			'indianahuntingforum.com',
 * 			'indianamasteranglers.com',
 * 			'indianaoutdoorsman.com'
 * 		)
 * 	),
 *
 * 	//vhost with aliases
 * 	'foo.com' => array(
 * 		'aliases' => array(
 * 			'alias3',
 * 			'alias4'
 * 		)
 * 	),
 *
 * 	//vhost with redirects
 * 	'baz.com' => array(
 * 		'redirects' => array(
 * 			'bop.net',
 * 			'bip.com',
 * 			'bap.com'
 * 		)
 * 	)
 * );
 */

/**
 * Config format:
 * base_vhost_index:	the starting numeric index for the vhost files created (e.g. 10)
 * base_recipe_name:	the base name for the recipe files (e.g. "vhost_")
 * port:				port the virtualhost listens on
 */
$cfg = array(
	'base_vhost_index' => 10,
	'base_recipe_name' => 'vhost_',
	'port' => 8000,
);

//Reset the vhost_index
$vhost_index = $cfg['base_vhost_index'];

/**
 * Subdomains array format:
 * 	'subdomain' => '/doc/root'
 */
$subdomains = array(
	'www' => '/home/vhosts/@@site@@',
);

/**
 * See file comment at head for docs on $sites array
 */
$sites = array(
	//vhost with aliases and redirects
	'indianasportsman.com' => array(
		'redirects' => array(
			'hoosierhunting.net',
			'indianahuntingforum.com',
			'indianamasteranglers.com',
			'indianaoutdoorsman.com',
		),
	),
	'mainehuntingforums.com',
	'arizonahuntingforums.com',
	'wisconsinoutdoorsman.com' => array(
		'aliases' => array(
			'wisconsintroutfishing.com',
			'wisconsintroutstreams.com',
		),
	),
	'theboxotruth.com' => array(
		'aliases' => array(
			'tbotoh.com',
		),
	),
	'xenforo-addons_carbonmedia.net',
	'ohiogamefishing.com',
	'ohiosportsman.com' => array(
		'aliases' => array(
			'eriesportfishing.com',
			'icefishingohio.com',
			'ohiofishingforum.com',
			'ohiofishingtalk.com',
			'ohiohunter.com',
			'ohiosportsman.net',
		),
	),
	'glocktalk.com',
	'boiseriders.net',
	'pnwriders.com',
	'core.carbonmedia.net',
	'michigan-sportsman.com',
	'veggiegardener.com',
	'thefirearmsforum.com',
	'beginningfarmers.org',
	'microskiff.com',
	'biggamehunt.net' => array(
		'aliases' => array(
			'st1.biggamehunt.net',
			'st2.biggamehunt.net',
			'st3.biggamehunt.net',
		),
	),
	'pavementsucks.com',
  'gunandgame.com',
  'msgo.com',
  '1911addicts.com'
);

/**
 * Recipe template for chef recipe which:
 * 1. Creates document root directory (if it doesn't already exist)
 * 2. Installs the vhost conf file into /etc/httpd/sites-available
 * 3. Enables the vhost with symlink into /etc/httpd/sites-enabled
 * 4. Restarts apache to enable the vhost
 */
$recipe_template = <<< EOF
rightscale_marker :begin

directory "@@docroot@@" do
    owner "rightscale"
    group "apache"
    mode 02775
    recursive true
    action :create
end

template "/etc/httpd/sites-available/@@vhost_filename@@.conf" do
    source "@@vhost_conf_file@@"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

link "/etc/httpd/sites-enabled/@@vhost_filename@@.conf" do
    to "/etc/httpd/sites-available/@@vhost_filename@@.conf"
end

bash "restart_httpd" do
    code <<-EOF
        service httpd restart
    EOF
end

rightscale_marker :end
EOF;

/**
 * Conf file template for redirect type of vhost
 */
$redirect_conf_template = <<< EOF
<VirtualHost *:@@port@@>
    ServerName @@redirected_domain@@
    @@vhost_aliases@@
    RedirectMatch permanent /(.*) http://@@vhost_domain_name@@/$1
</VirtualHost>
EOF;

/**
 * Conf file template for normal vhost (with optional server aliases)
 */
$conf_template = <<< EOF
<VirtualHost *:@@port@@>
    ServerName @@vhost_domain_name@@
    @@vhost_aliases@@
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

/**
 * metadata.rb template (append these lines to the main cookbook)
 */
$metadata_template = 'recipe "cmg_oo::@@recipe_name@@", "Sets up the @@vhost_domain_name@@ vhost(s) and alias(es) (if applicable)."';

// Process the $sites array and create supporting files
foreach ($sites as $site => $vhosts) {
	if (is_array($vhosts)) {
		//process aliases
		if (array_key_exists('aliases', $vhosts) && count($vhosts['aliases']) > 0) {
			create_vhost($site, $vhosts['aliases']);
		} else {
			//create vhost without aliases
			create_vhost($site);
		}
		//process redirects
		if (array_key_exists('redirects', $vhosts) && count($vhosts['redirects']) > 0) {
			//create vhost redirects
			foreach ($vhosts['redirects'] as $redirect) {
				create_vhost_redirect($redirect, $site);
			}
		}
	} else {
		//just a regular entry, no redirects or aliases because no array for domain
		create_vhost($vhosts);
	}
}

/**
 * Creates a vhost with optional ServerAlias(es).
 * Appends metadata.rb, creates vhost_*.rb and vhost_*.conf.erb files
 *
 * @param string $domain used for ServerName
 * @param array $aliases for vhost (string domains)
 * @return void
 */
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
	foreach ($subdomains as $subdomain => $docroot) {
		$docroot = str_replace('@@site@@', $site_name, $docroot);
		if (!empty($subdomain)) {
			$site = "{$subdomain}.{$site_name}";
		}
		if (!is_null($aliases)) {
			foreach ($aliases as $idx => $alias) {
				array_push($aliases, "{$subdomain}.{$alias}");
			}
		}
	}

	if (!is_null($aliases)) {
		echo "vhost: {$domain} <- (" . implode(' ', $aliases) . ")\n";
		array_unshift($aliases, $domain);
	} else {
		echo "vhost: {$domain}\n";
	}
	$sitename_underscore = str_replace('.', '_', $domain);
	$find = array(
		'@@recipe_name@@',
		'@@docroot@@',
		'@@port@@',
		'@@vhost_filename@@',
		'@@vhost_domain_name@@',
		'@@site@@',
		'@@vhost_aliases@@',
		'@@vhost_conf_file@@',
	);
	$replace = array(
		'vhost_' . $sitename_underscore,
		$docroot,
		$cfg['port'],
		"{$vhost_index}-{$site}",
		$site,
		$site,
		(!is_null($aliases)) ? 'ServerAlias ' . implode(' ', $aliases) : "ServerAlias {$domain}",
	);
	array_push($replace, "{$replace[0]}.conf.erb");
	$recipe_tmp = str_replace($find, $replace, $recipe_template);
	$conf_tmp = str_replace($find, $replace, $conf_template);
	$metadata_tmp = str_replace($find, $replace, $metadata_template);
	create_file("{$replace[0]}.rb", $recipe_tmp);
	create_file("{$replace[0]}.conf.erb", $conf_tmp);
	append_file("metadata.rb", $metadata_tmp);
	append_file("metadata.rb", "");
	$vhost_index++;
}

/**
 * Creates a vhost redirect using RedirectMatch.
 * Appends metadata.rb, creates vhost_*.rb and vhost_*.conf.erb files
 *
 * @param string $redirect domain to redirect
 * @param string $domain to redirect to (used for RedirectMatch directive)
 * @return void
 */
function create_vhost_redirect($redirect, $domain) {
	global
	$subdomains,
	$vhost_index,
	$cfg,
	$recipe_template,
	$redirect_conf_template,
	$metadata_template;

	$site_name = $site = $domain;

	//add subdomains
	foreach ($subdomains as $subdomain => $docroot) {
		$docroot = str_replace('@@site@@', $site_name, $docroot);
		if (!empty($subdomain)) {
			$site = "{$subdomain}.{$site_name}";
		}
	}

	echo "redirect: {$redirect} -> {$domain}\n";
	$sitename_underscore = str_replace('.', '_', $site);
	$redirect_underscore = str_replace('.', '_', $redirect);

	$find = array(
		'@@recipe_name@@',
		'@@docroot@@',
		'@@port@@',
		'@@vhost_filename@@',
		'@@vhost_domain_name@@',
		'@@site@@',
		'@@vhost_aliases@@',
		'@@redirected_domain@@',
		'@@vhost_conf_file@@',
	);
	$replace = array(
		'vhost_redirect_' . $redirect_underscore . '_to_' . $sitename_underscore,
		$docroot,
		$cfg['port'],
		"{$vhost_index}-redirect_{$redirect}",
		$site,
		$site,
		(!is_null($aliases)) ? 'ServerAlias ' . implode(' ', $aliases) : "ServerAlias www.{$redirect}",
		$redirect,
	);
	array_push($replace, "{$replace[0]}.conf.erb");
	$recipe_tmp = str_replace($find, $replace, $recipe_template);
	$conf_tmp = str_replace($find, $replace, $redirect_conf_template);
	$metadata_tmp = str_replace($find, $replace, $metadata_template);
	create_file("{$replace[0]}.rb", $recipe_tmp);
	create_file("{$replace[0]}.conf.erb", $conf_tmp);
	append_file("metadata.rb", $metadata_tmp);
	append_file("metadata.rb", "");
	$vhost_index++;
}

/**
 * Simple wrapper to create a file with initial contents
 * @param string $filename to create
 * @param string $contents to write to file
 * @return void
 */
function create_file($filename, $contents) {
	$fp = fopen($filename, 'w+');
	fwrite($fp, $contents);
	fclose($fp);
}

/**
 * Simple wrapper to append to a file with some content
 * @param string $filename to append to
 * @param string $contents to append to file
 * @return void
 */
function append_file($filename, $contents) {
	$fp = fopen($filename, 'a+');
	fwrite($fp, $contents . "\n");
	fclose($fp);
}

?>
