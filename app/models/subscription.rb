class Subscription < ApplicationRecord
	belongs_to :user, primary_key: :user_id

	# validates :

	enum payment_cycle: { oneMonth: 10, twoMonths: 20, threeMonths: 30, sixMonths: 60, year:120}
	enum payment_method: { cash: 0, card: 1}
end
