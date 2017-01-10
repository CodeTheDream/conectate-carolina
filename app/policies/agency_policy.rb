class AgencyPolicy < ApplicationPolicy
 def index?
   true
 end

 def show?
   true
 end

 def update?
   return false if @current_user == @user
   @user.admin?
 end

 def create?
   return false if @current_user == @user
   @user.admin?
 end

 def destroy?
   return false if @current_user == @user
   @user.admin?
 end
end
