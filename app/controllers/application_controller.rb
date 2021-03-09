class ApplicationController < ActionController::Base
  include Pundit
  include Response
  include ExceptionHandler
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

  def response_format
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attatchment; filename=\"#{Date.today}-#{controller_path.split("_").first}-list.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end
end
