module Youroom
  class DestroyParticipation < Participation
    def path
      File.join(@path, 'redmine', 'participation', 'destroy')
    end
  end
end
