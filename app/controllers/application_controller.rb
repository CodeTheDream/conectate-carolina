class ApplicationController < ActionController::Base
  include Pundit
  include Response
  include ExceptionHandler

  rescue_from Pundit::NotAuthorizedError do 
    redirect_to root_url, alert: 'Access denied'
  end
  
  protect_from_forgery with: :exception
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(_options = {})
    { locale: I18n.locale }
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
