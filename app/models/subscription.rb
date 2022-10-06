class Subscription < ApplicationRecord
    belongs_to :user

    enum payment_cycle: { oneMonth: 1, twoMonths: 2, threeMonths: 3, sixMonths: 6, year:12}
    enum payment_method: { cash: 0, card: 1}
end
