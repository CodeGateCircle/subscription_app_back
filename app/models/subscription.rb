class Subscription < ApplicationRecord
  belongs_to :user, primary_key: :user_id

    # validates
    validates :name, presence: true
    validates :price, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to:9999999}
    validates :is_paused, inclusion: { in: [true, false] }
    validates :remarks, length: { maximum: 1000 }

  enum payment_cycle:  { oneMonth: 10, twoMonths: 20, threeMonths: 30, sixMonths: 60, year:120}
  enum payment_method: { cash: 0, card: 1}

  def format_res
    res = self.attributes.symbolize_keys
    res.transform_keys!(first_payment_date: :firstPaymentDate)
    res[:firstPaymentDate].strftime("%Y-%m-%d")
    res.transform_keys!(is_paused: :isPaused)
    res.transform_keys!(image_url: :imageUrl)
    res.transform_keys!(payment_cycle: :paymentCycle)
    res.transform_keys!(payment_method: :paymentMethod)

    res.delete(:user_id)
    res.delete(:created_at)
    res.delete(:updated_at)
    return res
  end

  def format_res_search
    res = self.attributes.symbolize_keys
    res.transform_keys!(image_url: :imageUrl)
    res.transform_keys!(payment_cycle: :paymentCycle)

    res.delete(:id)
    res.delete(:created_at)
    res.delete(:updated_at)
    return res
  end
end
