$: << File.dirname(__FILE__) + "/../app/concerns/"
$: << File.dirname(__FILE__) + "/../lib/last_fm/"
$: << File.dirname(__FILE__) + "/../lib/lyrics/"
require "last_fm/list"

module LastFm
  class List
    def initialize(user)
      @user = user
      mock_document
    end
  end
end
