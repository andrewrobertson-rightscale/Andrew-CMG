#!/bin/env php
<?php
passthru('mysql -hdb-rds.oo.carbonmedia.net -ucmg_admin -poKYQK29ixLjzQ8te27g3 --exec="select \"\" as heartbeat, NOW() as now"');
?>
