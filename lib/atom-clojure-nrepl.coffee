AtomClojureNreplView = require './atom-clojure-nrepl-view'
expressions = require './expressions'
nrepl = require './nrepl'

module.exports =
  atomClojureNreplView: null

  activate: (state) ->
    @view = new AtomClojureNreplView(state.atomClojureNreplViewState)
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
    nrepl.evaluate expression, (err, result) =>
      if err
        @view.addError err
      else
        @view.addResult result

  evaluateFile: ->
    editor = atom.workspace.activePaneItem
    expression = expressions.file(editor)
    console.log('evaluating file\n', expression)
    nrepl.evaluate(expression, (err, result) -> console.log(err || result))

  evaluateContainingExpression: ->
    editor = atom.workspace.activePaneItem
    console.log('evaluating containing expression\n')
