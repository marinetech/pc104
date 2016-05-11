A. Explanation of required files and their meaning:

start.script			-	This file is the one exectuted by CRON at specified times. This is where main execution begins.
do_work.script			-	(optional) This file just passes the settings to the binary. It is executed after all fault checks have passed
example_plugin_bin		-	(optional) This file is a binary, which accesses the rs232 port and collects data from the sensor
example_plugin_postprocessor	-	(optional) This is the separate data post processor.
get_page.script			-	This file outputs the HTML with all the required settings. Try exectuing it, and you will see the HTML output.
init.script			-	You have to have this file, but it does not have to do anything. Here, you do everything that needs to be done on system startup, like loading drivers
postconf.script			-	this file is executed after the settings.conf file is written by the web service
postprocessors.script		-	(optional) I separated the post processor execution to here, but you don't have to do it.
settings.conf			-	This file contains all the settings, and is read and written by the WEB service, using the get_page.script 
singleton.script		-	(optional) This file just makes sure there is only one instance of this plugin is running. In future, it will also make a serial port lock.


B. Use cases:

a. Install:
	1. User installs the deb package with the update
	2. System will recognize the new plugin automatically.

b. Settings:

	1. User accesses the built-in web server.
	2. User clicks on the left hand menu with the name of the plugin (taken from settings.conf)
	3. Web server runs the get_page.script of the plugin, and displays the settings page
	4. User makes changes and presses submit.
	5. System writes the settings from the web page to the settings.conf file.
	6. System runs postconf.script. This is usually used to install the selected cron times from settings.conf to the crontab for the plugin user.

c. Useage:

	1. Cron executes start.conf

C. Gotchas:

1. The plugin user is non-priviledged. 
2. The installation of the deb package is run under root
3. Refer to deb file specification for the meaning of scripts in DEBIAN folder
4. The plugin should "police" itself in terms of semaphores, locks (like the singleton.script file above), getting stuck and such.
5. global_settings folder referenced in scripts contains settings for the whole system
6. eval "$POWER_DOWN $POWER_PORT" turns off the power to a sensor
7. eval "$POWER_UP $POWER_PORT" turns on the power to a sensor
