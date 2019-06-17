class AchievedBadgesController < ApplicationController
  def index
    @achieved_badges = current_user.achieved_badges
  end
end
