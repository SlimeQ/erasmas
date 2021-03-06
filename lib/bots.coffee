class JabberBot extends Character

CORE.JabberBot = JabberBot

class Dog extends Character
  constructor: () ->
    super
    @attributes.jabber = "Woof, woof..."
    @attributes.delay ?= 5000
    setInterval @runme, @attributes.delay

  runme: =>
    if @parent?
      r = Math.random()
      if r < .2
        @goThrough utils.pickOne(@parent.childrenOfType("Door"))
      else if r < .5
        @broadcast new Event "talk", this, "words": @attr("jabber")
      else
        ""

CORE.Dog = Dog

class Cat extends Character
  constructor: () ->
    super

  hear: (evt) ->
    if evt.contents.thing?.isa("Dog") and evt.type is "add"
      @goThrough utils.pickOne(@parent.childrenOfType("Door"))

CORE.Cat  = Cat
