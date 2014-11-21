name             'cmg_oo'
maintainer       'Carbon Media Group'
maintainer_email 'rchristy@carbonmediagroup.com'
license          'All rights reserved'
description      'CMG Owned and Operated Cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "rightscale"
depends "repo_git"
depends "repo"
depends "app_php"
depends "app"
depends "web_apache"
depends "apache2"

recipe "cmg_oo::etc_hosts", "Sets up /etc/hosts."
recipe "cmg_oo::install_nfs_client", "Installs NFS client."
recipe "cmg_oo::mount_nfs_vhosts", "Mounts /home/vhosts via NFS via SoftNAS NFS export."
recipe "cmg_oo::bashrc", "Sets up the bash environment."
recipe "cmg_oo::extra_tools", "Installs some extra tools from yum repos."
recipe "cmg_oo::php_ini", "Sets up php.ini file."
recipe "cmg_oo::php_apc_ini", "Sets up php.d/apc.ini file."
recipe "cmg_oo::create_db_users", "Creates the database users for all the groupbuilder sites."
recipe "cmg_oo::create_db_users_run", "Runs the create database users script."
recipe "cmg_oo::nfs_db_backup", "Installs the nfs_db_backup script."
recipe "cmg_oo::nfs_db_backup_run", "Runs the nfs_db_backup script on demand."
recipe "cmg_oo::nfs_db_backup_cron", "Installs cron job to run the nfs_db_backup script."
recipe "cmg_oo::nfs_db_restore", "Installs the nfs_db_restore script."
recipe "cmg_oo::nfs_db_restore_run", "Runs the nfs_db_restore script on demand."
recipe "cmg_oo::vhost_default", "Sets up the default vhost for lb healthchecks."
recipe "cmg_oo::sendgrid_default_postfix", "Sets up postfix to use sendgrid."
recipe "cmg_oo::mod_expires", "Link expires.load into /etc/httpd/modules-enabled."
recipe "cmg_oo::clear_old_httpd_logs", "Clears old httpd logs."
recipe "cmg_oo::vhost_indianasportsman_com", "Sets up the indianasportsman.com vhost for apache."
recipe "cmg_oo::vhost_www_indianasportsman_com", "Sets up the indianasportsman.com vhost for apache."

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