class SessionsController < Devise::SessionsController

  after_action :custom_welcome, only: :create

  def custom_welcome
    flash[:notice] = "Привет, #{current_user.nickname}!"
  end

end