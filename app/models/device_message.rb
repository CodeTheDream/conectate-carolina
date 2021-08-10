class DeviceMessage < ApplicationRecord
  belongs_to :device
  belongs_to :message
end
