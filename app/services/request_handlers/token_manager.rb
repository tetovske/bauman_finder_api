# frozen_string_literal: true

# module for handling requests
module RequestHandlers
  # Token helper module
  module TokenManager
    def in_black_list?(token)
      return true unless find_by(:token => token).nil?
      false
    end

    def check_token(token)
      Other::JwtDecoder.call.decode_key(token).bind do |data|
        exp = data['expires'].to_time
        return true if (exp - Time.now > 0) && !BlackList.in_black_list?(token)
        return false
      end
      false
    end

    def destroy_token(token)
      rec = BlackList.new(token: token)
      if rec.valid?
        rec.save
        return true
      end
      false
    end

    def generate_token(email)
      data = {
        user_email: email,
        expires: Time.now + 1.hours.to_i
      }
      Other::JwtDecoder.call.encode_key(data).value!
    end

    def find_by_token(token)
      Other::JwtDecoder.call.decode_key(token).bind do |val|
        return User.where(email: val['user_email']).first
      end
    end
  end
end