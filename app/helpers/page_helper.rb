module PageHelper
  def account_username
    current_user.bf_username
  end
end