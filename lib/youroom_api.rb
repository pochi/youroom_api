require "rubygems"
require "object_extention"
require "oauth"
require 'uri'
require 'net/http'

module Youroom
  # base
  autoload :VERSION, 'youroom_api/version'
  autoload :BASE_URL, 'youroom_api/base_url'
  autoload :Base, 'youroom_api/base'
  autoload :OAuth, 'youroom_api/youroom'
  autoload :Request, 'youroom_api/request'

  # relation home
  autoload :HomeTimeline, 'youroom_api/request/timeline'
  autoload :UnreadTimeline, 'youroom_api/request/unread_timeline'
  autoload :MyGroup, 'youroom_api/request/my_group'

  # relation entry
  autoload :Entry, 'youroom_api/request/entry'
  autoload :GetEntry, 'youroom_api/request/get_entry'
  autoload :PostEntry, 'youroom_api/request/post_entry'
  autoload :DestroyEntry, 'youroom_api/request/destroy_entry'

  # relation room
  autoload :AddRoom, 'youroom_api/request/add_room' # enterprise only
  autoload :GetRoomList, 'youroom_api/request/get_room_list' # enterprise only

  # relation participation
  autoload :Participation, 'youroom_api/request/participation'
  autoload :AddParticipation, 'youroom_api/request/add_participation' # enterprise only
  autoload :DestroyParticipation, 'youroom_api/request/destroy_participation' # enterprise only
end

