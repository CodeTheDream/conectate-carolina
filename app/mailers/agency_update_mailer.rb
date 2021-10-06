class AgencyUpdateMailer < ApplicationMailer

  def new_agency_update_email
    @agency = params[:agency]
    @aur = params[:agency_update_request]

    mail(from: @agency.email, to: 'admin@saf-unite.org', cc: (Proc.new { User.where(role: 'admin').pluck(:email) }).call, subject: 'You got a new organization update request!')
  end

end
