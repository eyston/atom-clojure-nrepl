{View} = require 'atom'

module.exports =
class AtomClojureNreplView extends View
  @content: ->
    @div class: 'atom-clojure-nrepl tool-panel panel-bottom', =>
      @div class: 'panel-heading padding heading', =>
        @span class: 'title', 'clojure nrepl'
        @span class: 'heading-close icon-remove-close pull-right', click: 'close'
      @div class: 'messages-scroller', outlet: 'messagesScroller', =>
        @div class: 'messages padded', outlet: 'messages'

  # Tear down any state and detach
  destroy: ->
    @detach()

  close: ->
    @detach()

  attach: ->
    atom.workspaceView.prependToBottom(this) unless @hasParent()

  addResult: (message) ->
    @addMessage(new ResultView(message: message))

  addError: (message) ->
    @addMessage(new ErrorView(message: message))

  addMessage: (view) ->
    @attach()
    @messages.append(view)
    @messagesScroller.animate({ scrollTop: @messages.height() })

class ResultView extends View
  @content: (params) ->
    @div class: 'result', =>
      @pre params.message

class ErrorView extends View
  @content: (params) ->
    @div class: 'error', =>
      @pre params.message
