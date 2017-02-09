class ContactMailer < ApplicationMailer
  #autoammly applies to mail to:
  # default from: 'ismael1589@gmail.com'

default to: 'ismael1589@gmail.com'

  def contact_email(user, email, body)
    @user = user
    @email = email
    @body = body

    mail from: email, subject: 'You have a new comment on your site'
  end

end
