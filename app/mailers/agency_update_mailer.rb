class AgencyUpdateMailer < ApplicationMailer
  def new_agency_update_email(agency, aur, admins)
    @agency = agency
    @aur = aur
    @admins = admins

    mail(from: agency.email, to: 'admin@saf-unite.org', subject: 'You got a new organization update request!')
  end
end
