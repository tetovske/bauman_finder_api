
# Api module 
module Api
  # FindController class
  class FindController < ApplicationController
    include RequestHandlers

    def find
      if check_token(params[:token])
        render :json => { response: RequestHandler.call(params).value_or('data not found!') }
      else
        render :json => { message: 'expired token!' }
      end
    end

    private

    def check_token(token)
      Other::JwtDecoder.call.decode_key(token).bind do |data|
        exp = data['expires'].to_time
        return true if (exp - Time.now > 0) && !BlackList.in_black_list?(token)
        return false
      end
      false
    end
  end
end
