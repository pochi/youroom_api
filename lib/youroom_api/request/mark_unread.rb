# coding: utf-8

module Youroom
  class MarkUnread < Mark
    def path
      File.join(url, 'mark_unread')
    end
  end
end
