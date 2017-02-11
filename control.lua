require("map_sets")

script.on_init(function()
	spectator_surface = game.create_surface("spectator", map_sets.spectator_box.gen_settings)
	mapheight = map_sets.spectator_box.gen_settings.height
	mapwidth = map_sets.spectator_box.gen_settings.width
end
)

script.on_event(defines.events.on_player_joined_game, function(event)
	player = game.players[event.player_index]
	player.teleport({0,0}, "spectator")
end
)


script.on_event(defines.events.on_tick, function(event)
	if(event.tick == 60) then
		local tiles = {}
		for i=-mapheight/2,mapheight/2 do
			for j=-mapwidth/2,mapwidth/2 do
				tile = {name = map_sets.spectator_box.tile_type, position = {i,j}}
				table.insert(tiles, tile)
			end
		end
		spectator_surface.set_tiles(tiles, true)	
		
		local all_ents = spectator_surface.find_entities()
		for _, ent in pairs(all_ents) do
			if ent.name ~= "player" then
				ent.destroy()
			end
		end
	end

end
)
