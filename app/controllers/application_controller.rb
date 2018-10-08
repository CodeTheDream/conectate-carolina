class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(_options = {})
    { locale: I18n.locale }
  end

  def user_not_authorized
    flash[:alert] = 'Access denied'
    redirect_to(request.referrer || root_path)
  end
end
