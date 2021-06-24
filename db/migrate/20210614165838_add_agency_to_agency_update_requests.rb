class AddAgencyToAgencyUpdateRequests < ActiveRecord::Migration[6.1]
  def change
    add_reference :agency_update_requests, :agency, null: false, foreign_key: true
  end
end
