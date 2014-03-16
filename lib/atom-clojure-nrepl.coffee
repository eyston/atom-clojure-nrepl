AtomClojureNreplView = require './atom-clojure-nrepl-view'
expressions = require './expressions'
nrepl = require './nrepl'

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
    expression = expressions.lastExpression(editor)
    console.log('evaluating last expression\n', expression)
    nrepl.evaluate(expression)

  evaluateFile: ->
    editor = atom.workspace.activePaneItem
    expression = expressions.file(editor)
    console.log('evaluating file\n', expression)
    nrepl.evaluate(expression)

  evaluateContainingExpression: ->
    editor = atom.workspace.activePaneItem
    console.log('evaluating containing expression\n')
