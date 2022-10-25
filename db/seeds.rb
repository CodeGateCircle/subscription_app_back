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
                        user_id: "tester"
                    )

Subscription.create(    name: "Youtube Premium",
                        price: 1180,
                        first_payment_date: "2022-10-15",
                        remarks: "お試し終了",
                        is_paused: false,
                        payment_cycle: 10,
                        user_id: "tester"
                    )

Subscription.create(    name: "Apple Music",
                        price: 980,
                        first_payment_date: "2022-10-15",
                        remarks: "学割",
                        is_paused: false,
                        payment_cycle: 10,
                        user_id: "tester"
                    )
