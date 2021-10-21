# Preview all emails at http://localhost:3000/rails/mailers/agency_update_mailer
class AgencyUpdateMailerPreview < ActionMailer::Preview
  def new_agency_update_email
    # Set up a temporary agency update request for the preview
    agency = Agency.create(name: "Ctd", address: "201 W Main st.", city: "Durham", state: "NC", zipcode: "27701", email: "me@codethedream.org")
    aur = AgencyUpdateRequest.new(agency_id: agency.id, name: "Code the Dream", address: "201 W Main st.", city: "Durham", state: "NC", zipcode: "27701",
                                  phone: "919-989-0184", submitted_by: "Michael", submitter_email: "michael@codethedream.org")

    AgencyUpdateMailer.with(agency_update_request: aur).new_agency_update_email(agency)
  end
end
