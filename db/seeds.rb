User.create(    user_id: "tester",
                currency: "JPY",
                language: "Japanese"
            )

Subscription.create(    name: "Amazon prime",
                        price: 200,
                        first_payment_date: "2022-10-15",
                        remarks: "学割",
                        is_paused: false,
                        payment_cycle: 10,
                        payment_method: 0,
                        user_id: "tester"
                    )
