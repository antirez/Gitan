GITAN - a minimal personal git system
=====================================

This is a very simple Ruby/Sinatra application to create / inspect repositories
using a web interface.

There is no access control list at all in this system:

* The git repositories are accessible only by users having their ssh public key into the authorized_keys file of the git user.
* The web interface is protected by HTTP authentication with a single username/password for all the users.

The program is only able to show available repositories with some information
like branches and latest commits, and to allow the creation of new git
repositories.

INSTALLATION INSTRUCTIONS
-------------------------

* Get some small instance everywhere, I use a linode small instance.
* Install git, ruby, sinatra.
* Create a *git* user, you can call the user in a different way if you wish as you can set the username into the gitan_config.rb file.
* Create the ~/.ssh/authorized_keys file, and populate it with all the public keys of users that should access the system.
* Create the repository root somewhere, something like: **mkdir /var/gitan/repositories**
* Make sure the git user can write into /var/git/repositories.
* Clone the gitan application somewhere.
* **cp gitan_config.rb.example gitan_config.rb**
* Edit gitan_config.rb and modify it accordingly to your setup.
* Run the Sinatra application. I just use **ruby app.rb** inside screen.
* MAKE SURE you run the sinatra application using the git user.
* You are ready to use the system, go to http://yourhost.com:4567

CONTRIBUTE
----------

I'll likely be not able to work a lot more on this, so please if you
like the idea contribute to make it a little more interesting.

I'll merge anything will make it better, but I've one design principia
for this project, that is, I wrote this small program to escape from
gitolite "black box" affair. Gitan should evolve into a direction where
everything is simple to understand *and* fix if there is some problem,
so the repositories should always be, at the end of the day, bare git
repositories without too much hooks magic and ssh tricks.

SCREENSHOTS
-----------

![Screenshot 1](http://antirez.com/misc/gitan_screenshot_1.png)

![Screenshot 2](http://antirez.com/misc/gitan_screenshot_2.png)

![Screenshot 3](http://antirez.com/misc/gitan_screenshot_3.png)

Ciao,
Salvatore

