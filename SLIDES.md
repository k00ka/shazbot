<style type="text/css">

  h1, h2, h3 {
    margin-top:       0;
  }

  ul, li {
    line-height:      125%;
  }

  li {
    padding-top:      0.5em;
  }

  .remark-slide-container:first-child .remark-slide-number {
    visibility:       hidden;
  }

  .remark-slide-number,
  .remark-slide-content .footer {
    position:         absolute;
    bottom:           0.5rem;
    font-size:        67%;
    line-height:      24px;
    opacity:          1;
  }

  .remark-slide-number {
    right:            1rem;
  }

  .remark-slide-content .footer {
    left:             1rem;
  }

  .remark-slide-content .footer img {
    vertical-align:   middle;
    max-height:       24px;
    margin-right:     0.5rem;
  }

  .hidden-comment {
    display:          none;
  }

  .half img {
    width:            50%;
  }

  .appendix {
    background-color: #ffffc0;
  }

  .smaller img {
    width:            90%;
  }

  .small img {
    width:            20%;
  }

  .green {
    color:            #00c000;
  }

  .remark-code {
    font-size:        20px;
  }

  .nb-call {
    color:            #0000c0;
  }

  .nb {
    font-size:        67%;
    text-align        right;
    vertical-align:   bottom;
    color:            #0000c0;
  }

  code, .remark-code {
    color:            #ff0000;
  }

  pre code.remark-code {
    color:            inherit;
  }

  a code {
    color:            inherit;
  }

</style>

layout: true
class: middle

.footer[![Logo](https://raw.githubusercontent.com/k00ka/shazbot/master/images/shazbot.png)Shazbot - the Ruby Hack Night Chatbot]
---
name: inverse
class: center, middle, inverse

<!--·······················································································
If you aren't seeing this as an interactive presentation, in slides, open it with Remarkise:
https://gnab.github.io/remark/remarkise?url=https://raw.githubusercontent.com/k00ka/shazbot/master/SLIDES.md
·························································································-->
.hidden-comment[<br><br><br><br>**If you are reading this**, you are looking at the *source*! <br> [Use
Remarkise instead](https://gnab.github.io/remark/remarkise?url=https://raw.githubusercontent.com/k00ka/shazbot/master/SLIDES.md) to **see the presentation in interactive slides**.<br><br><br><br>]

# Shazbot - the Ruby Hack Night Chatbot
Chatbot and Slack workshop - May 11, 2016 
Presented by David Andrews, Ryatta Group  
Developed by David Andrews and Jason Schweier, 2016  
  
![Mork saying Shazbot!](https://raw.githubusercontent.com/k00ka/shazbot/master/images/mork.png)

---

#Agenda
* connecting to Slack
* establishing behaviours
* matchers
* handlers
  * errors
* examples:
  * GIFs in a context
  * current temperatures
  * Wolfram Alpha
---

#Connecting to Slack
* API endpoint
* token
---

# Matchers
* can be a String or Regexp (anchored or not)
* can be a Lambda (block) taking one argument (message text)
* the first truthy matcher has its handler executed
---

# Handlers
* a method name (symbol) defined in the Behaviour::Handlers context
* takes one argument (message data)
* message data contains channel, team, text, timestamp, type, user
* access to entire Slack API (note: self is client)
---

# APIs
Slack has two types:
1. Web: basic set of interactions
1. Realtime: A web client using web-sockets - supports callbacks  
* the web client has a tool for command-line interactions

Slack-ruby-client gem:
* provides Slack metadata through instance variables

Let's look...
---

#Slack Web API
##https://api.slack.com/methods
Select endpoints:
* chat_postMessage - channel, text, [attachments, icon_emoji, icon_image]
* channels_list
* channels_info - channel (you can find out lots of great stuff!)
* users_info - user
* files_upload - filename, file|post, [title, initial_comment]
---

#Slack Realtime API
##https://api.slack.com/rtm
Select endpoints:
* on <event> - register a block to be executed when event occurs
* typing - message slack with the "user is typing" flag
* ping - keep alive request
---

#Instance variables in the gem
* url - A WebSocket Message Server URL
* self - The authenticated bot user
* team - Details on the authenticated user's team
* users - A hash of user objects by user ID
* channels - A hash of channel objects, one for every channel visible to the authenticated user
* groups - A hash of group objects, one for every group the authenticated user is in
* ims - A hash of IM objects, one for every direct message channel visible to the authenticated user
* bots - Details of the integrations set up on this team
---

#Code review
* bot.rb - the runner
* shazbot.rb - the class
* behaviour.rb - matchers and handlers
---

#Design considerations
* Triggers
  * Keyphrases
  * 3rd-party
  * Natural Language Processing
    * Compound Sentences
* Responses
  * Personality
---

#Idea generation
* use cases
* APIs and 3rd-party services
* useful tools

---

#Make it so

.small[![k00ka](https://emoji.slack-edge.com/T06HP930V/k00ka/86bb3793626f1a2e.png)]
