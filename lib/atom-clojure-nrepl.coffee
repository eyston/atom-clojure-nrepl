AtomClojureNreplView = require './atom-clojure-nrepl-view'
expressions = require './expressions'

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
    editor = atom.workspace.activePaneItem
    console.log('evaluating last expression\n', expressions.lastExpression(editor))

  evaluateFile: ->
    editor = atom.workspace.activePaneItem
    console.log('evaluating file\n', expressions.file(editor))

  evaluateContainingExpression: ->
    editor = atom.workspace.activePaneItem
    console.log('evaluating containing expression\n')
