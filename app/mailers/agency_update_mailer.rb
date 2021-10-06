class AgencyUpdateMailer < ApplicationMailer
  def new_agency_update_email
    @agency = params[:agency]
    @aur = params[:agency_update_request]

    mail(from: @agency.email, cc: 'admin@saf-unite.org', subject: 'You got a new organization update request!')
  end
end
