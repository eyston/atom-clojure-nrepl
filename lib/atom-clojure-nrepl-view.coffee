{View} = require 'atom'

module.exports =
class AtomClojureNreplView extends View
  @content: ->
    @div class: 'atom-clojure-nrepl overlay from-top', =>
      @div "The AtomClojureNrepl package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "atom-clojure-nrepl:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "AtomClojureNreplView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
