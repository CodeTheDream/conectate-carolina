class AgencyUpdateMailer < ApplicationMailer

  def new_agency_update_email
    @agency = params[:agency]
    @aur = params[:agency_update_request]

    mail(from: @agency.email, to: 'admin@saf-unite.org', cc: (Proc.new { User.where(role: 'admin').pluck(:email) }).call, subject: 'You got a new organization update request!')
  end

  def agency_update_approval_email
    @aur = params[:agency_update_request]
    attachments.inline['SAFLogo1.png'] = File.read('/Users/nrai/Documents/conectate-carolina/app/assets/images/SAFLogo1.png')

    mail(from: 'admin@saf-unite.org', to: @aur.email, subject: 'Your organization information is updated!')
  end
end
