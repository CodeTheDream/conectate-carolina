class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :set_locale

  after_action  :verify_authorized, unless: :devise_controller?

private

	def set_locale
		I18n.locale = params[:locale] if params[:locale].present?
	end

	def default_url_options(options = {})
		{locale: I18n.locale}
	end

end
