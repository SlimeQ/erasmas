class Queue
  constructor: ->
    @queue = []

  add: (msg) -> @queue.push msg

  remove: -> @queue.shift()

  all_for: (field, value) ->

  length: -> @queue.length

  empty: -> @queue.length is 0

  toString: -> "Queue(length=#{@length()})"

CORE.Queue = Queue

class InputMessage
  constructor: (@source, @destination, @type, @args) ->
    @timestamp = new Date().toString()

  rep: ->
    source: @source,
    destination: @destination,
    type: @type,
    timestamp: @timestamp,
    args: @args

class OutputMessage
  constructor: (@source, @destination, @type, @result, @args) ->
    @timestamp = new Date().toString()

  rep: ->
    source: @source,
    destination: @destination,
    type: @type,
    timestamp: @timestamp,
    args: @args,
    results: @results

# Sample input message

# {
#   source: 1234,          # character gid
#   destination: null,     # null = system
#   type: "create-room",   # message type
#   timestamp: "Fri Jul 27 2012 20:13:32 GMT-0400 (EDT)",
#   args: {                # arguments to the type
#     name: "Room Name"
#   }
# }

# Sample output message
#
# {
#   source: null,
#   destination: 1234,
#   type: "create-room",
#   timestamp: "Fri Jul 27 2012 20:13:32 GMT-0400 (EDT)",
#   result: "OK",
#   args: {
#   }
# }
