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
  autoload :Participation, 'youroom_api/participation'
  autoload :CreateParticipation, 'youroom_api/create_participation'
  autoload :DestroyParticipation, 'youroom_api/destroy_participation'
  autoload :CreateUser, 'youroom_api/user'
  autoload :CreateRoom, 'youroom_api/room'
  autoload :Entry, 'youroom_api/entry'
  autoload :HomeTimeline, 'youroom_api/timeline'
  autoload :UnreadTimeline, 'youroom_api/unread_timeline'
end

