# coding: utf-8

module Youroom
  class MarkRead < Mark
    def path
      File.join(url, 'mark_read?format=json')
    end
  end
end
