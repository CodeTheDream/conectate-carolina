class AddSubmittedByAndSubmitterEmailToAgencyUpdateRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :agency_update_requests, :submitted_by, :string
    add_column :agency_update_requests, :submitter_email, :string
  end
end
