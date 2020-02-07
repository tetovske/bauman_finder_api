class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    puts 'FACEBOOK OMNIAUTH CALLBACK'
    @user = User.from_omniauth_facebook(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def vkontakte
    puts "VKONTAKTE HANDLING"
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth_vk(request.env["omniauth.auth"])
    puts @user.to_s

    if @user.persisted?
      puts 'USER PERSISTED'
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "VK") if is_navigational_format?
    else
      puts "USER NOT PERSISTED: #{@user.to_json}"
      @user.tap do |user|
        user.skip_confirmation! 
        user.save!
      end
      puts 'USER SAVED'
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.vk_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  end

  def failure
    puts 'Error while omniauth callback handling'
    redirect_to doc_path
  end
end