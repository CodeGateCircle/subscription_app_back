class User < ApplicationRecord
    self.primary_key = :user_id

    has_many :subscriptions

    enum currency: { JPY: 0, USD: 1}
    enum language: { Japanese: 0, English: 1}
end
