class PaymentCycle < ApplicationRecord
    has_many :subscriptions
end
