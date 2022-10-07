class Subscription < ApplicationRecord
	belongs_to :user, primary_key: :user_id

	# validates

	enum payment_cycle: { oneMonth: 10, twoMonths: 20, threeMonths: 30, sixMonths: 60, year:120}
	enum payment_method: { cash: 0, card: 1}

	def format_res
        res = self.attributes.symbolize_keys
		res.transform_keys!(first_payment_date: :firstPaymentDate)
		res.transform_keys!(is_paused: :isPaused)
		res.transform_keys!(image_url: :imageUrl)
		res.transform_keys!(payment_cycle: :paymentCycle)
		res.transform_keys!(payment_method: :paymentMethod)

        res.delete(:user_id)
        res.delete(:created_at)
        res.delete(:updated_at)
        return res
    end
end
