local d6_side_info = SMODS.D6_Side({
	key = "planetarium_side",
	loc_txt = {},
	config = {planet_cards_gained = 1},
	atlas = "d6_side_planetarium",
	icon_pos = {x=6, y=2},
	upgrade = "planetarium_plus_side",
	loc_vars = function(self, info_queue, card, d6_side)
		return {vars = {d6_side.extra.planet_cards_gained}}
	end,
	calculate = function(self, card, context, d6_side)
		if context.setting_blind and not card.getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				func = (function()
					G.E_MANAGER:add_event(Event({
						func = function() 
							local card = create_card('Planet',G.consumeables, nil, nil, nil, nil, nil, 'planetarium')
							card:add_to_deck()
							G.consumeables:emplace(card)
							G.GAME.consumeable_buffer = 0
							return true
						end}))
						card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.PURPLE})
					return true
				end)}))
		end
	end,
	register = function(self, order)
		if order and order == self.order then
			SMODS.GameObject.register(self)
		end
	end,
	order = 5,
})

D6_JokerDisplay.D6_Side_Definitions[d6_side_info.key] = {
	text = {},
	reminder_text = {
		{ text = '+' },
		{ ref_table = 'card.joker_display_values', ref_value = 'planet_cards_gained' },
		{ text = ' Planet' },
	},
	reminder_text_config = { colour = G.C.SECONDARY_SET.Planet }
}

return d6_side_info