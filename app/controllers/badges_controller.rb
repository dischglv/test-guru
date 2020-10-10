class BadgesController < ApplicationController
  def index
    @badges = Badge.all
    @awarded_badges = current_user.badges
  end
end
