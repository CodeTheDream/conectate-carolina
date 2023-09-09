class AgencyUpdateRequestPolicy < ApplicationPolicy
  def index?
    return false if @current_user == @user
    @user.admin?
  end

  def edit?
    index?
  end

  def update?
    index?
  end
end
