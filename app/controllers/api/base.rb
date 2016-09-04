module API
  # from http://www.thegreatcodeadventure.com/making-a-rails-api-with-grap/
  class Base < Grape::API
    mount API::V1::Base
  end
end
