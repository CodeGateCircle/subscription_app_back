class User < ApplicationRecord
    self.primary_key = :user_id

    has_many :subscriptions

    enum currency: { JPY: 0, USD: 1}
    enum language: { Japanese: 0, English: 1}

    def format_res
        res = user_json = self.attributes.symbolize_keys
        res.transform_keys!(user_id: :userId)
        res.delete(:create_at)
        res.delete(:update_at)
        return res
    end
end
