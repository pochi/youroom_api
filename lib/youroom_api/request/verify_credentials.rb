module Youroom
  class VerifyCredentials < Request
    def path
      File.join(url, 'verify_credentials', '?format=json')
    end
  end
end
