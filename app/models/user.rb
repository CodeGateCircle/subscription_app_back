class User < ApplicationRecord
    has_many :subscriptions

    belongs_to :currency
    belongs_to :language
end
