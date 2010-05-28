require "rubygems"
require "object_extention"
require "oauth"
require 'uri'
require 'net/http'

module Youroom
  autoload :VERSION, 'youroom_api/version'
  autoload :BASE_URL, 'youroom_api/base_url'
  autoload :Base, 'youroom_api/base'
  autoload :OAuth, 'youroom_api/youroom'
  autoload :Request, 'youroom_api/request'
  autoload :Entry, 'youroom_api/entry'
  autoload :Participation, 'youroom_api/participation'
  autoload :HomeTimeline, 'youroom_api/timeline'
  autoload :UnreadTimeline, 'youroom_api/unread_timeline'
  autoload :PostEntry, 'youroom_api/post_entry'
end

