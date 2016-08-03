name             'cmg_oo'
maintainer       'Carbon Media Group'
maintainer_email 'rchristy@carbonmediagroup.com'
license          'All rights reserved'
description      'CMG Owned and Operated Cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.14'

depends "rightscale"
depends "repo_git"
depends "repo"
depends "app_php"
depends "app"
depends "web_apache"
depends "apache2"

recipe "cmg_oo::etc_hosts", "Sets up /etc/hosts."
recipe "cmg_oo::httpd_conf", "Sets up /etc/httpd/conf/httpd.conf."
recipe "cmg_oo::httpd_bgh_conf", "Sets up /etc/httpd/conf/httpd.conf for BGH server."
recipe "cmg_oo::install_nfs_client", "Installs NFS client."
recipe "cmg_oo::mount_nfs_vhosts", "Mounts /home/vhosts via NFS via SoftNAS NFS export."
recipe "cmg_oo::bashrc", "Sets up the bash environment."
recipe "cmg_oo::extra_tools", "Installs some extra tools from yum repos."
recipe "cmg_oo::php_ini", "Sets up php.ini file."
recipe "cmg_oo::php56_ini", "Sets up php.ini file (v5.6+)."
recipe "cmg_oo::php_apc_ini", "Sets up php.d/apc.ini file."
recipe "cmg_oo::create_db_users", "Creates the database users for all the sites."
recipe "cmg_oo::create_db_users_run", "Runs the create database users script."
recipe "cmg_oo::nfs_db_backup", "Installs the nfs_db_backup script."
recipe "cmg_oo::nfs_db_backup_run", "Runs the nfs_db_backup script on demand."
recipe "cmg_oo::nfs_db_backup_cron", "Installs cron job to run the nfs_db_backup script."
recipe "cmg_oo::nfs_db_restore", "Installs the nfs_db_restore script."
recipe "cmg_oo::nfs_db_restore_run", "Runs the nfs_db_restore script on demand."
recipe "cmg_oo::vhost_default", "Sets up the default vhost for lb healthchecks."
recipe "cmg_oo::sendgrid_default_postfix", "Sets up postfix to use sendgrid."
recipe "cmg_oo::mod_expires", "Link expires.load into /etc/httpd/modules-enabled."
recipe "cmg_oo::mod_rewrite", "Link rewrite.load into /etc/httpd/modules-enabled."
recipe "cmg_oo::clear_old_httpd_logs", "Clears old httpd logs."
recipe "cmg_oo::global_php", "Creates _GLOBAL.php in /home/vhosts."
recipe "cmg_oo::set_newrelic_hostname", "Sets the New Relic Hostname in /etc/newrelic/nrsysmond.cfg."
recipe "cmg_oo::remove_newrelic", "Remove New Relic from server."
recipe "cmg_oo::biggamehunt_net_cron", "Sets up the biggamehunt.net drush cron hourly cronjob."
recipe "cmg_oo::vhost_indianasportsman_com", "Sets up the www.indianasportsman.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_redirect_hoosierhunting_net_to_www_indianasportsman_com", "Sets up the www.indianasportsman.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_redirect_indianahuntingforum_com_to_www_indianasportsman_com", "Sets up the www.indianasportsman.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_redirect_indianamasteranglers_com_to_www_indianasportsman_com", "Sets up the www.indianasportsman.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_redirect_indianaoutdoorsman_com_to_www_indianasportsman_com", "Sets up the www.indianasportsman.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_mainehuntingforums_com", "Sets up the www.mainehuntingforums.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_arizonahuntingforums_com", "Sets up the www.arizonahuntingforums.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_wisconsinoutdoorsman_com", "Sets up the www.wisconsinoutdoorsman.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_theboxotruth_com", "Sets up the www.theboxotruth.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_xenforo-addons_carbonmedia_net", "Sets up the www.xenforo-addons_carbonmedia.net vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_ohiogamefishing_com", "Sets up the www.ohiogamefishing.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_ohiosportsman_com", "Sets up the www.ohiosportsman.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_glocktalk_com", "Sets up the www.glocktalk.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_boiseriders_net", "Sets up the www.boiseriders.net vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_pnwriders_com", "Sets up the www.pnwriders.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_core_carbonmedia_net", "Sets up the core.carbonmedia.net vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_michigan-sportsman_com", "Sets up the www.michigan-sportsman.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_veggiegardener_com", "Sets up the www.veggiegardener.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_thefirearmsforum_com", "Sets up the www.thefirearmsforum.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_newsletter_carbonmedia_net", "Sets up the newsletter.carbonmedia.net vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_beginningfarmers_org", "Sets up the www.beginningfarmers.org vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_microskiff_com", "Sets up the www.microskiff.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_biggamehunt_net", "Sets up the www.biggamehunt.net vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_biggamehunt_net_80", "Sets up the www.biggamehunt.net vhost(s) and alias(es) (if applicable) on port 80 (for isolation)."
recipe "cmg_oo::vhost_pavementsucks_com", "Sets up the www.pavementsucks.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::vhost_360tuna_com", "Sets up the www.360tuna.com vhost(s) and alias(es) (if applicable)."
recipe "cmg_oo::fix_curl_tls", "Fixes CURL to support TLS for PayPal requirement (updates curl using yum and city-fan repo)."
recipe "cmg_oo::install_php56", "Installs PHP v5.6, removes PHP v5.3"
recipe "cmg_oo::fix_curl_tls_php56", "Fixes CURL to support TLS for PayPal requirement (updates curl using yum and city-fan repo) for PHP v5.6."
recipe "cmg_oo::newsletter_cron", "Runs the newsletter.carbonmedia.net cron job."

#bashrc Attributes
attribute "bashrc/server/name",
  :display_name => "Server name (for bash prompt)",
  :description => "Use ENV -> RS_SERVER_NAME",
  :required => "required",
  :recipes => [ "cmg_oo::bashrc" ]

attribute "bashrc/server/deployment",
  :display_name => "Deployment name (for bash prompt)",
  :description => "Use ENV -> RS_DEPLOYMENT_NAME",
  :required => "required",
  :recipes => [ "cmg_oo::bashrc" ]

#global Attributes
attribute "newrelic/server_monitoring/deployment_prefix",
  :display_name => "New Relic Deployment Prefix (end in :)",
  :description => "e.g. CTV:",
  :required => "required",
  :recipes => [
    "cmg_oo::set_newrelic_hostname"
  ]
attribute "newrelic/server_monitoring/hostname",
  :display_name => "New Relic Hostname",
  :description => "e.g. 5-arr-CarbonTV-app #191",
  :required => "required",
  :recipes => [
    "cmg_oo::set_newrelic_hostname"
  ]
