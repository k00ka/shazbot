Shazbot - the Ruby Hack Night Chatbot
=====================================

Slides and assets for the Shazbot workshop [first presented at Toronto Ruby Hack Night, May 11, 2016]  
Workshop for learning Chatbots and Slack  
Created by David Andrews and Jason Schweier  

Slides for the workshop are here:  
https://gnab.github.io/remark/remarkise?url=https://raw.githubusercontent.com/k00ka/shazbot/master/SLIDES.md

###Introduction
![Mork says Shazbot!](http://www.unmotivating.com/wp-content/uploads/2014/08/ntpIdWz.jpg)

This project is a simple Ruby + Slack project. If you follow the instructions below, you can test your machine in advance of the workshop.

We have provided a repository which mimics the setup we used last time, so it should be familiar. The code to be created is found in the ``lib/`` directory.

###Setup

Here are the steps to get you started with the repo.

1. For this workshop, you will need a laptop with the following:
  - [x] Ruby 2.x  
  - [x] A Github account  

  Note: We have included a ``.ruby-version`` file locked to 2.2.3, which you can change to any Ruby 2.x version if you don't have 2.2.3 installed  
  More detailed instructions for each platform are included in the footer. Refer there if you are having issues.

1. Fork the repo (optional, recommended):
  From the page https://github.com/k00ka/shazbot, click the Fork button in the top-right corner. Copy the new repo address (in a box just below the thick red line) into your clipboard. Detailed instructions on forking a repo can be found here: https://help.github.com/articles/fork-a-repo/

1. At Ryatta Group we use rbenv, and so we've included some optional elements - just skip them if you're using rvm or are not versioning your Ruby. If you forked the repo above, your repo_address will be in your clipboard. If not, you should use my repo_address ``git@github.com:k00ka/shazbot.git``

  ```sh
  % git clone <repo_address>
  % cd shazbot
  % gem install bundler
  Fetching: bundler-1.7.4.gem (100%)
  Successfully installed bundler-1.7.4
  1 gem installed
  % bundle
  Fetching gem metadata from https://rubygems.org/.........
  Resolving dependencies...
  Installing rake 10.3.2
  ...
  Using bundler 1.7.4
  Your bundle is complete!
  Use `bundle show [gemname]` to see where a bundled gem is installed.
  ```
  Note: if you use rbenv...
  ```sh
  % rbenv rehash
  ```
  You are (almost) there!

## To get a Slack API token
1. In a web browser, go to slack.com and log in,
![](images/one.png)
1. Click on Your teams in the top right corner, and choose TorontoRB,
  - If TorontoRB is not there, go to http://slack.rubytoronto.com and do so,
![](images/two.png)
1. Choose Apps & Integrations from the side menu,
![](images/three.png)
1. Choose Build you own in the top right corner,
![](images/four.png)
1. Choose Make a Custom Integration on the right side,
![](images/five.png)
1. Choose Bots under Build a Custom Integration,
![](images/six.png)
1. Under bots, choose a username for your bot - make it unique and end with “bot”, and click Add bot integration,
![](images/seven.png)
1. Copy the API token, finish the form and click Save integration,
![](images/eight.png)
1. Back in slack, in the TorontoRB group, choose Open a Direct Message “+”,
![](images/nine.png)
1. Type in the name of your bot, and click Go,
![](images/ten.png)
1. You are now able to direct message “DM” your bot!
![](images/twelve.png)


- Sign up for the [Toronto Ruby Slack Team](https://torontoruby.slack.com/)
- Sign in after the invite email
- Visit the [Slack API docs](https://api.slack.com)
- Under `Authentication` on the left panel, click on `Tokens for Testing`
- Request a token for the TorontoRB team

Note: you will have to enter your password and click a confirmation button agreeing to the Slack API Terms of Service.

1. MORE TO COME To test your machine:
  ```sh
  % git checkout epic1
  % ruby asteroids.rb
  ```
1. Go into Slack
1. Invite your bot
1. Other instructions
