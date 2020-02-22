# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      @user = User.from_omniauth_facebook(request.env['omniauth.auth'])
      omniauth_handle_user(@user, :facebook)
    end

    def vkontakte
      @user = User.from_omniauth_vk(request.env['omniauth.auth'])
      omniauth_handle_user(@user, :vkontakte)
    end

    def github
      @user = User.from_omniauth_github(request.env['omniauth.auth'])
      omniauth_handle_user(@user, :github)
    end

    def omniauth_handle_user(user, provider)
      if user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: provider.to_s) if is_navigational_format?
      else
        if user.valid?
          user.tap do |u|
            u.skip_confirmation!
            u.save!
          end
          sign_in_and_redirect user, event: :authentication
          set_flash_message(:notice, :success, kind: provider.to_s) if is_navigational_format?
        else
          redirect_to new_user_registration_url, notice: 'Пользователь с такой почтой уже существует!'
        end
      end
    end

    def failure
      puts 'Error while omniauth callback handling'
      redirect_to doc_path
    end
  end
end
