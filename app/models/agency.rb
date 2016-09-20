require 'elasticsearch/model'

class Agency < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, analyzer: 'english', index_options: 'offsets'
      indexes :address, analyzer: 'english'
      indexes :city, analyzer: 'english'
    end
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['name^5', 'address', 'city']
          }
        },
        highlight: {
          pre_tags: ['<em>'],
          post_tags: ['</em>'],
          fields: {
            name: {},
            address: {},
            city: {}
          }
        }
      }
    )
  end
end
# Delete the previous agencies index in Elasticsearch
Agency.__elasticsearch__.client.indices.delete index: Agency.index_name rescue nil

# Create the new index with the new mapping
Agency.__elasticsearch__.client.indices.create \
  index: Agency.index_name,
  body: { settings: Agency.settings.to_hash, mappings: Agency.mappings.to_hash }
  
# Index all agency records from the DB to Elasticsearch
Agency.import # for auto sync model with elastic search
