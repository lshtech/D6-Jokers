local d6_joker_info = SMODS.D6_Joker({
	key = "impure_broke_die",
	loc_txt = {},
	discovered = false,
	d6_sides = {
		[1] = "curse_bankruptcy_side",
		[2] = "curse_bear_market_side",
		[3] = "curse_bankruptcy_side",
		[4] = "curse_bear_market_side",
		[5] = "curse_bankruptcy_side",
		[6] = "curse_bear_market_side"
	},
	impure = true,
	pure_upgrade = "j_dsix_pure_exchange_die",
	rarity = 4,
	cost = 20,
	config = {extra = {money_required = 150}},
	loc_vars = function(self, info_queue, card)
		SMODS.D6_Joker.loc_vars(self, info_queue, card)
		return {vars = {card.ability.extra.money_required}}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
			if G.GAME.dollars >= card.ability.extra.money_required then
				G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function() 
						card.set_ability(card, G.P_CENTERS[card.config.center.pure_upgrade], true)
                        return true
                    end
				}))
			end
		end
		SMODS.D6_Joker.calculate(self, card, context)
	end,
	register = function(self, order)
		if order and order == self.order then
			SMODS.Joker.register(self)
		end
	end,
	yes_pool_flag = "impure_joker",
	order = 1,
})

return d6_joker_info