class AgencyPolicy < ApplicationPolicy
  def index?
    true
  end
  def create?
    true
  end

end
