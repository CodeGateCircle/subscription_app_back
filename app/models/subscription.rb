class Subscription < ApplicationRecord
    belongs_to :payment_cycle
    belongs_to :payment_method
    belongs_to :subscription_image
    belongs_to :user
end
