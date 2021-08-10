class AddSubmittedByAndSubmitterEmailToAgencyUpdateRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :agency_update_requests, :submitted_by, :string, null: false
    add_column :agency_update_requests, :submitter_email, :string, null: false
  end
end
