#
#  TicketAgents are NPC that will sell a ticket that allows entry through a specific door
#
#    Requires a door attribute with the gid of the target door
#    Requires a cost attribute indicating the amount of money that is taken from the player character after a purchase
#
class TicketAgent extends Character
  constructor: ->
    super
    @attr("cost", 1) unless @attr("cost")?

  doorName: ->
    registry.get(@attr("door"))?.name || 'unknown'

  "buyticket": (character) ->
    if character.attr("money") || 0 > @attr("cost")
      character.attr "money", character.attr("money") - @attr("cost")
      ticket = new Ticket "Ticket to " + @doorName(),
        door: @attr('door')
        created_by: @gid
      character.add ticket
      "Ticket purchased via " + @doorName()
    else
      "You do not have enough money to buy a ticket via " + registry.get(@attr("door"))?.name

  interface:
    "buyticket": 1

#
#  Thing created by a TicketAgent. Allows entry through a specific door.
#
#    Requires a door attribute gid
#
class Ticket extends Thing
  constructor: ->
    super

  door: -> @attr("door")

#
#  Door subclass that can only be traverse when the character has in their possession
#  a Ticket for this specific door
#
class TicketDoor extends Door
  constructor: ->
    super

  canTraverse: (character) ->
    tickets = character.search "[Ticket]"
    correctTicket = null
    for ticket in tickets
      correctTicket = ticket if ticket.attr("door") is @gid
    if correctTicket?
      correctTicket.parent.remove correctTicket
      true
    else
      false

CORE.TicketAgent = TicketAgent
CORE.Ticket      = Ticket
CORE.TicketDoor  = TicketDoor

