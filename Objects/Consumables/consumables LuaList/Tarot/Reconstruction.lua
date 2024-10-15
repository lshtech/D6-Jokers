local tarot_info = SMODS.Consumable({
	key = "reconstruction",
	set = "Tarot",
	loc_txt = {},
	pos = {x=0, y=0},
	cost = 3,
	discovered = false,
	can_use = function(self, card)
		local d6_joker_selected = false
		for k, v in ipairs(G.jokers.cards) do
			if v.highlighted == true and v.config.center.d6_joker and v.config.center.upgrade then 
				d6_joker_selected = true 
			end
		end
		return d6_joker_selected
	end,
	use = function(self, card, area, copier)
		local selected_card
		for k, v in ipairs(G.jokers.cards) do
			if v.highlighted == true then selected_card = v end
		end
        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.4, func = function()
			local stored_d6_side_info = selected_card.ability.extra.local_d6_sides
			selected_card.set_ability(selected_card, G.P_CENTERS[selected_card.config.center.upgrade], true)
			for i = 1, #selected_card.ability.extra.local_d6_sides do
				selected_card.ability.extra.local_d6_sides[i].edition = stored_d6_side_info[i].edition
			end
            return true 
		end }))
	end,
	register = function(self, order)
		if order and order == self.order then
			SMODS.Consumable.super.register(self)
		end
	end,
	d6_consumable = true,
	order = 1,
})

return tarot_info