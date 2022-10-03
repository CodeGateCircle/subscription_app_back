# initial data

Currency.create!(
    currency: 'JPY'
)
Currency.create!(
    currency: 'USD'
)


Language.create!(
    language: 'Japanese'
)
Language.create!(
    language: 'English'
)


PaymentCycle.create!(
    payment_cycle: 'oneMonth'
)
PaymentCycle.create!(
    payment_cycle: 'twoMonths'
)
PaymentCycle.create!(
    payment_cycle: 'threeMonths'
)
PaymentCycle.create!(
    payment_cycle: 'sixMonths'
)
PaymentCycle.create!(
    payment_cycle: 'year'
)


PaymentMethod.create!(
    payment_method: 'cash'
)
PaymentMethod.create!(
    payment_method: 'card'
)
