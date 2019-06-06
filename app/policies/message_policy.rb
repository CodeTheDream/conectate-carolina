class MessagePolicy < ApplicationPolicy
  def index?
    return false if @current_user == @user
    @user.admin?
  end

  # def show?
  #   true
  # end

  def create?
    return false if @current_user == @user
    @user.admin?
  end

  def destroy?
    return false if @current_user == @user
    @user.admin?
  end

  def update?
    return false if @current_user == @user
    @user.admin?
  end

  def post?
    true
  end

  def unpost?
    true
  end

end
