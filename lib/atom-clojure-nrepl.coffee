AtomClojureNreplView = require './atom-clojure-nrepl-view'

module.exports =
  atomClojureNreplView: null

  activate: (state) ->
    @atomClojureNreplView = new AtomClojureNreplView(state.atomClojureNreplViewState)
    atom.workspaceView.command "atom-clojure-nrepl:evaluate-last-expression", => @evaluateLastExpression()
    atom.workspaceView.command "atom-clojure-nrepl:evaluate-file", => @evaluateFile()
    atom.workspaceView.command "atom-clojure-nrepl:evaluate-containing-expression", => @evaluateContainingExpression()

  deactivate: ->
    @atomClojureNreplView.destroy()

  serialize: ->
    atomClojureNreplViewState: @atomClojureNreplView.serialize()

  evaluateLastExpression: ->
    console.log('evaluating last expression')

  evaluateFile: ->
    console.log('evaluating file')

  evaluateContainingExpression: ->
    console.log('evaluating containing expression')
