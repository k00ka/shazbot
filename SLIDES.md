title: Shazbot - the Ruby Hack Night Chatbot
name: inverse
layout: true
class: inverse

---
class: center middle

# Shazbot - the Ruby Hack Night Chatbot
Chatbot and Slack workshop
David Andrews, Ryatta Group
Big thanks to Jason Schweier  
  
![Mork says Shazbot!](http://www.unmotivating.com/wp-content/uploads/2014/08/ntpIdWz.jpg)

---
class: middle

# Foundations
* connection to Slack
* establishing behaviours
* matchers
* handlers
  * errors
* examples:
  * GIFs in a context
  * current temperatures
  * Wolfram Alpha
---
class: middle

# Matchers
* can be a String or Regexp (anchored or not)
* can be a Lambda (block) taking one argument (message text)  
  
* the first truthy matcher has its handler executed
---
class: middle

# Handlers
* a method name (symbol) defined in the Behaviour::Handlers context
* takes one argument (message data)
* message data contains channel, team, text, timestamp, type, user
* access to entire Slack API (note: self is client)
---
class: middle

# Slack API
Two types:
1. Web: basic set of interactions
1. Realtime: A web client using web-sockets - supports callbacks  
  
* the web client has a tool for command-line interactions

# Gem API
* the gem we are using provides Slack metadata through instance variables
---
class: middle

#Slack Web API https://api.slack.com/methods
Select endpoints:
* chat_postMessage - channel, text, [attachments, icon_emoji, icon_image]
* channels_list
* channels_info - channel (you can find out lots of great stuff!)
* users_info - user
* files_upload - filename, file|post, [title, initial_comment]
---
class: middle

#Slack Realtime API https://api.slack.com/rtm
* on <event> - register a block to be executed when event occurs
* typing - message slack with the "user is typing" flag
* ping - keep alive request
---
class: middle

# The slack-ruby-client gem provides instance variables:
* url - A WebSocket Message Server URL
* self - The authenticated bot user
* team - Details on the authenticated user's team
* users - A hash of user objects by user ID
* channels - A hash of channel objects, one for every channel visible to the authenticated user
* groups - A hash of group objects, one for every group the authenticated user is in
* ims - A hash of IM objects, one for every direct message channel visible to the authenticated user
* bots - Details of the integrations set up on this team
---
class:middle

# Considerations
* Personality
* Triggers
  * Keyphrases
  * Third-party
  * Natural Language Processing
    * Compound Sentences
* Responses
  * Lulls & Nonsense
  * Hellos & Goodbyes
---
class: middle

#Code review
---
class: middle

#
