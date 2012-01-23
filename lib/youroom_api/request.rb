module Youroom
  class Request < Base
    attr_reader :access_token

    def initialize(access_token, url=BASE_URL)
      required_structure(access_token, ::OAuth::AccessToken)
      @access_token = access_token
      parse(url)
    end

    def get_entry(room_id, mutter_id=nil)
      GetEntry.new(access_token, room_id, mutter_id, url).get
    end

    def get_verify_credentials
      VerifyCredentials.new(access_token, url).get
    end

    def get_attachment(room_id, mutter_id)
      ShowAttachment.new(access_token, room_id, mutter_id, url).get
    end

    def get_all_timeline(params={ })
      HomeTimeline.new(access_token, params, url).get
    end

    def get_unread_timeline
      UnreadTimeline.new(access_token, url).get
    end

    def get_room_timeline(room_id, params={ })
      RoomTimeline.new(access_token, room_id, params, url).get
    end

    def create_entry(room_id, content, parent_id=nil)
      PostEntry.new(access_token, room_id, content, parent_id, url).post
    end

    def destroy_entry(room_id, mutter_id)
      DestroyEntry.new(access_token, room_id, mutter_id, url).delete
    end

    def get_my_group
      MyGroup.new(access_token, url).get
    end

    def mark_read(ids=[])
      MarkRead.new(access_token, ids, url).post
    end

    def mark_unread(ids=[])
      MarkUnread.new(access_token, ids, url).post
    end

    def get
      JSON.parse(access_token.get(path).body)
    end

    def post
      JSON.parse(access_token.post(path, params).body)
    end

    def delete
      JSON.parse(access_token.delete(path).body)
    end

    # enterprise api
    def create_room(billing_id, name)
      AddRoom.new(access_token, billing_id, name, url).post
    end

    def create_participation(billing_id, billin_group_id, email)
      AddParticipation.new(access_token, billing_id, billin_group_id, email, url).post
    end

    def destroy_participation(billing_id, billing_group_id, email)
      DestroyParticipation.new(access_token, billing_id, billing_group_id, email, url).delete
    end

    def get_room_list(billing_id)
      GetRoomList.new(access_token, billing_id, url).get
    end

    def create_user(billing_id, user)
      AddUser.new(access_token, billing_id, user, url).post
    end

    def get_user_list(billing_id)
      GetUserList.new(access_token, billing_id, url).get
    end

    def get_picture(room_id, participation_id)
      Picture.new(access_token, room_id, participation_id, url).get(false)
   end

    def get(parse=true)
      parse ? JSON.parse(access_token.get(path).body) : access_token.get(path)
    rescue => e
      puts "[Error forward to] " + path
      puts "[Error access_token is]"
      puts access_token.inspect
      puts e.inspect
    end

    def post
      JSON.parse(access_token.post(path, params).body)
    end

    def delete
      JSON.parse(access_token.delete(path).body)
    end
  end
end
