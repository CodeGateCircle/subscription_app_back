class User < ApplicationRecord
    has_many :subscriptions

    enum currency: { JPY: 0, USD: 1}
    enum language: { Japanese: 0, English: 1}
end
