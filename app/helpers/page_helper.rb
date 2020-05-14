# frozen_string_literal: true

module PageHelper
  def account_username
    return 'nameless' unless current_user

    current_user.tap do |usr|
      usr.update(bf_username: usr.username) if usr.bf_username.blank?
    end.bf_username
  end

  def user_bf_token
    current_user&.update_token if current_user&.bf_api_token.blank?
    current_user&.bf_api_token
  end

  def random_student(mode = :all)
    Student.where.not(id_abitur: nil).to_a.sample
  end
end
