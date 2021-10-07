class AgencyUpdateMailer < ApplicationMailer

  def new_agency_update_email
    @agency = params[:agency]
    @aur = params[:agency_update_request]

    mail(from: 'noreply@conectatecarolina.org', to: 'admin@saf-unite.org', reply_to: @agency.email, cc: User.where(role: 'admin').pluck(:email), subject: 'You got a new organization update request!')
  end

  def agency_update_approval_email
    @aur = params[:agency_update_request]
    attachments.inline['SAFLogo1.png'] = File.read('app/assets/images/SAFLogo1.png')

    mail(from: 'admin@saf-unite.org', to: @aur.email, subject: 'Your organization information is updated!')
  end
end
