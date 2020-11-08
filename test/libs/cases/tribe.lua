require("wrapper")(function(test, transfromage, client)
	test("open tribe interface", function(expect)
		client:on("tribeInterface", expect(function(tribe)
			p("Received event tribeInterface")
			assert(tribe)

			assert_eq(tostring(tribe), "Tribe", "str(t)")

			assert(tribe._client)
			assert(tribe.id)
			assert(tribe.name)
			assert(tribe.greetingMessage)
			assert(tribe.map)

			assert_eq(type(tribe.members), "table", "type(t)")
			assert(#tribe.members > 0)

			local member
			for m = 1, #tribe.members do
				member = tribe.members[m]
				m = "t[" .. m .. "]."
				assert_neq(member._client, nil, m .. "_client")
				assert_neq(member.id, nil, m .. "id")
				assert_neq(member.playerName, nil, m .. "playerName")
				assert_neq(member.gender, nil, m .. "gender")
				assert_neq(member.lastConnection, nil, m .. "lastConnection")
				assert_neq(member.rolePosition, nil, m .. "rolePosition")
				assert_neq(member.gameId, nil, m .. "gameId")
				assert_neq(member.roomName, nil, m .. "roomName")
			end

			assert_eq(type(tribe.roles), "table", "type(t)")
			assert((next(tribe.roles)))
		end))

		client:openTribeInterface(true)
	end)

	test("tribe message", function(expect)
		client:on("tribeMessage", expect(function(memberName, message)
			p("Received event tribeMessage")
			if playerName == client.playerName then
				assert_eq(message, "666", "message")
			end
		end))

		client:sendTribeMessage("666")
	end)

	test("tribe greeting message", function(expect)
		local currentMessage = client.tribe.greetingMessage

		client:on("tribeInterface", expect(function(tribe)
			p("Received event tribeInterface")
			client:setTribeGreetingMessage(currentMessage)

			assert(tribe.greetingMessage == "69")
		end))

		client:setTribeGreetingMessage("69")
		client:openTribeInterface()
	end)
end)