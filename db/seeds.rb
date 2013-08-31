user = User.create(name: "Gaby", email: "gaby@gaby.com")

deck = Deck.create(name: "Spanish-English")

deck.cards.create(prompt: "school", answer: "escuela")
deck.cards.create(prompt: "array", answer: "cadena")
deck.cards.create(prompt: "computer", answer: "computadora")
deck.cards.create(prompt: "awesome", answer: "chevere")
deck.cards.create(prompt: "girlfriend", answer: "enamorada")

user.rounds.create(completion_status: false, deck_id: deck.id)
