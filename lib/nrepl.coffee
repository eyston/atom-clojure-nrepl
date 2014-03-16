nreplClient = require 'nrepl-client'

module.exports =
  evaluate: (expression) ->
    if expression
      con = nreplClient.connect({port:49248})
      con.once 'connect', ->
        con.eval expression, (err, result) ->
          console.log(err || result)
          con.end()
