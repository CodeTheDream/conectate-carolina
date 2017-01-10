class CategoryPolicy < ApplicationPolicy
  # attr_reader :category
  #
  # def initialize(user, category)
  #   super(user, category)
  #   @category = record
  # end

  def index?
    true
  end

  def show?
    true
  end

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

end
