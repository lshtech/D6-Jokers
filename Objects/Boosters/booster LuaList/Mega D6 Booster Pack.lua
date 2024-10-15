local booster_info = SMODS.Booster({
	key = "mega_d6_booster_pack",
	weight = 0.15,
	cost = 8,
	config = {extra = 4, choose = 2},
	discovered = false,
	create_card = function(self, card)
		local card_to_make = nil
		if not card.ability.cards_made then card.ability.cards_made = 0 end
		if card.ability.cards_made < card.ability.extra/2 then 
			card_to_make = create_card("d6_jokers", G.pack_cards, nil, nil, true, true, nil, 'dsix_mega_booster')
		else 
			card_to_make = create_card("d6_consumables", G.pack_cards, nil, nil, true, true, nil, 'dsix_mega_booster')
		end
		card.ability.cards_made = card.ability.cards_made + 1
		return card_to_make
	end,
	group_key = "d6_booster_pack",
	register = function(self, order)
		if order and order == self.order then
			SMODS.Booster.register(self)
		end
	end,
	order = 1,
})

return booster_info