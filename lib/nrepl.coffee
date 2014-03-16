fs = require 'fs'
path = require 'path'

nreplClient = require 'nrepl-client'


module.exports =
  evaluate: (expression, cb) ->
    if expression
      getPortForProject (port) ->
        if port
          con = nreplClient.connect({port:port})
          con.once 'connect', ->
            con.eval expression, (err, result) ->
              cb err, result
              con.end()

getPortForProject = (cb) ->
  portPath = path.join(atom.project.getRootDirectory().path, '.nrepl-port')

  fs.exists portPath, (result) ->
    if result
      fs.readFile portPath, (err, content) ->
        cb(content and parseInt(content))
    else
      cb(null)
