				*NOSTR TO GOURCE*
		Display nostr events as Gource visualisation.
		
		
Objectif:
Display nostr events for the last hour/24hour:
	- general : show a general map or relays classify by
		GOURCELOG: -> TLD -> Relayname -> Relay.relays
					|> NIPS -> Suppored nip.nipnumber
	- per pubkey:
		for a specified pubkey, this would show all events published
		by a specific pubkey. classify by:
		GOURCELOG: -> nostr.key/nip05 -> Event type > Relay.com
	- per relay:
		for a specified relay, this would classify events by type.
		It would be nice to have a folder for paid invoices.


Méthodologie:
Using gource isnt hard, making custom log can be painfull but i think,
because we have the proper tools (nostcat), it wont be too hard.