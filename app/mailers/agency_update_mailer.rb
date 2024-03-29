class AgencyUpdateMailer < ApplicationMailer

  def new_agency_update
    @agency = params[:agency]
    @aur = params[:agency_update_request]

    mail(from: 'noreply@conectatecarolina.org', to: 'admin@saf-unite.org', reply_to: @aur.submitter_email, cc: User.where(role: 'admin').pluck(:email), subject: 'You got a new organization update request!')
  end

  def agency_update_approval
    @aur = params[:agency_update_request]

    mail(from: 'admin@saf-unite.org', to: @aur.email, subject: 'Your organization information is updated!')
  end
end
