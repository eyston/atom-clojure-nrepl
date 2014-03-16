AtomClojureNreplView = require './atom-clojure-nrepl-view'

module.exports =
  atomClojureNreplView: null

  activate: (state) ->
    @atomClojureNreplView = new AtomClojureNreplView(state.atomClojureNreplViewState)

  deactivate: ->
    @atomClojureNreplView.destroy()

  serialize: ->
    atomClojureNreplViewState: @atomClojureNreplView.serialize()
