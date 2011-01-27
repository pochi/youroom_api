module Youroom
  class VerifyCredencials < Request
    def path
      File.join(url, 'verify_credencials', '?format=json')
    end
  end
end
