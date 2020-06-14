class Admin::BaseController < ApplicationController

  layout 'admin'

  before_action :authenticate_user!
  before_action :admin_required!

  private

  def admin_required!
    unless current_user.admin?
      redirect_to root_path, alert: 'Недостаточно прав для просмотра данной страницы'
    end
  end

end