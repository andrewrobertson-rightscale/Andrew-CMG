<?php
$sites = array(
	'360tuna.com',
	'airsoftsociety.com',
	'arkansashunting.net',
	'beekeepingforums.com',
	'bersaforum.com',
	'caracalforum.com',
	'catfish1.com',
	'cattleforum.com',
	'chickenforum.com',
	'cztalk.com',
	'dairygoatinfo.com',
	'firearmstalk.com',
	'georgiahunting.org',
	'georgiapacking.org',
	'glockforum.com',
	'hipointfirearmsforums.com',
	'homesteadingtoday.com',
	'marlinforum.com',
	'midwest-horse.com',
	'missouriwhitetails.com',
	'observedtrials.net',
	'ohiowaterfowlerforum.com',
	'paracordforum.com',
	'pigforum.com',
	'preparedsociety.com',
	'rabbitdogs.net',
	'rugertalk.com',
	'springfieldforum.com',
	'steyrclub.com',
	'thegoatspot.net',
	'thektog.org',
	'theslingshotforum.com',
	'tractorforum.com',
	'twospoke.com',
	'velospace.org',
	'xdforum.com'
);

if ($argc >= 2) {
	$sites = array();
	for ($i = 1; $i < $argc; $i++) {
		array_push($sites, $argv[$i]);
	}
}

$total_sites = count($sites);
$local_hosts = file_get_contents('c:\windows\system32\drivers\etc\hosts');
$local_hosts = str_replace("\r\n", "", $local_hosts);

echo "\n\n";

echo "Flushing DNS...\n\n";
system("ipconfig /flushdns >> nul");
system("ipconfig /registerdns >> nul");

echo str_pad("LOC?", 4, " ") . " ";
echo str_pad("DOMAIN", 32, " ") . " ";
echo str_pad("BASE", 16, " ") . " ";
echo str_pad("WWW", 16, " ") . " ";
echo str_pad("VIDEOS", 16, " ") . " ";
echo "\n";
echo str_pad("", 4, "-") . " ";
echo str_pad("", 32, "-") . " ";
echo str_pad("", 16, "-") . " ";
echo str_pad("", 16, "-") . " ";
echo str_pad("", 16, "-") . " ";
echo "\n";
foreach($sites as $site) {
	$output = array(
		'in_local' => (strpos($local_hosts, $site) ? 'X' : ''),
		'base' => gethostbyname($site),
		'www' => gethostbyname("www.{$site}"),
		'videos' => gethostbyname("videos.{$site}")
	);
	echo str_pad($output['in_local'], 4, " ") . " ";
	echo str_pad($site, 32, " ") . " ";
	echo str_pad($output['base'], 16, " ") . " ";
	echo str_pad($output['www'], 16, " ") . " ";
	echo str_pad($output['videos'], 16, " ") . " ";
	echo "\n";
}
echo "\nFinished checking DNS for {$total_sites} sites!\n";

?>