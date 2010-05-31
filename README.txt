= youroom_api

* http://github.com/pochi/youroom_api

== DESCRIPTION:

simple api for youroom.

== FEATURES/PROBLEMS:

* youroom client (list of features or problems)

-----------------------------
how to use
-----------------------------

This api follow youroom api using oauth.(api doc:http://apidoc.youroom.in/)
Each api follow:
  Enterprise:Group/create          ---->     create_room(billing_id, name)
  Enterprise:Group/index           ---->     get_room_list(billing_id)
  Enterprise:Participation/add     ---->     create_participation(billing_id, billing_group_id, email)
  Enterprise:Participation/remove  ---->     create_participation(billing_id, billing_group_id, email)
  REST:Entry/create                ---->     post_entry(room_id, content)
  REST:Entry/destroy               ---->     destroy_entry(room_id, mutter_id)
  REST:Entry/show                  ---->     get_entry(room_id, mutter_id)
  REST:Group/my                    ---->     get_my_group
  REST:Home Timeline(all)          ---->     get_all_timeline
  REST:Home Timeline(unreads)      ---->     get_unread_timeline
  REST:Room Timeline               ---->     get_entry(room_id)

-----------------------------
sample1: Get my timeline
-----------------------------

require 'rubygems'
require 'youroom_api'

YOUROOM_URL = "https://api.youroom.in/"

consumer = OAuth::Consumer.new(consumer_key,
                               consumer_sercret,
                               :site => YOUROOM_URL)

info = consumer.get_access_token(nil, { },
                                 {:x_auth_mode=>"client_auth",
                                  :x_auth_username=> "pochi.black@gmail.com",
                                  :x_auth_password=> password})

access_token = OAuth::AccessToken.new(consumer,
                                      info.params['oauth_token'],
                                      info.params['oauth_token_secret'])

client = Youroom::Request.new(access_token)
puts client.get_all_timeline.body

== SYNOPSIS:

  FIX (code sample of usage)

== REQUIREMENTS:

* ruby 1.8.7 or later
* rspec 1.3.0 or later
* ww

== INSTALL:

* FIX (sudo gem install, anything else)

== DEVELOPERS:

After checking out the source, run:

  $ rake newb

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.

== LICENSE:

(The MIT License)

Copyright (c) 2010 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
