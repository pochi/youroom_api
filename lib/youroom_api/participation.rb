module Youroom
  class CreateParticipation < Request
    attr_reader :room_id, :email

    def initialize(room_id, email, url=BASE_URL)
      [room_id, email].each {|arg| required_structure(arg, String, Symbol) }
      @room_id, @email = room_id, email
      super(url)
    end

    def path
      File.join(@path, 'redmine', 'participation', 'create')
    end

    def params
      { :room_id => room_id, :email => email }
    end
  end
end
