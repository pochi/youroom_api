# coding: utf-8

module Youroom
  class MarkUnread < Mark
    def path
      File.join(url, 'unmark_read')
    end
  end
end
