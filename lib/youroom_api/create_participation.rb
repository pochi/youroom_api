module Youroom
  class CreateParticipation < Participation
    def path
      File.join(@path, 'redmine', 'participation', 'create')
    end

  end
end
