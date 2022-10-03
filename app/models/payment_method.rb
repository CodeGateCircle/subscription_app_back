class PaymentMethod < ApplicationRecord
    has_many :subscriptions
end
