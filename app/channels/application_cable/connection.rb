module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
      def find_verified_user
        # if verified_user = User.find_by(id: cookies.encrypted[:user_id])
        # TODO
        # https://stackoverflow.com/questions/35501931/send-auth-token-for-authentication-to-actioncable
        if verified_user = User.first
          verified_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
