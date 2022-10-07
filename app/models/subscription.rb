class Subscription < ApplicationRecord
    belongs_to :user

    enum payment_cycle: { one_month: 10, two_months: 20, three_Months: 30, six_months: 60, year:120}
    enum payment_method: { cash: 0, card: 1}
end
