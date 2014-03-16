_ = require 'underscore'

module.exports =
  lastExpression: (editor) ->
    position = editor.getCursor().getBufferPosition()

    startPosition = findExpressionStartPosition editor, movePositionByCount -2, position, editor.buffer
    endPosition = findExpressionEndPosition editor, movePositionByCount -1, position, editor.buffer

    if startPosition and endPosition
      editor.getTextInRange([startPosition, endPosition])

  file: (editor) ->
    editor.getText()

  containingExpression: (editor) ->
    # TODO: this would evaluate all the way out to the biggest expression it could get
    # e.g. (square [x] (* x x)) (prn (square |5)) with '|' as the cursor (inside square 5)
    #      would evaluate (prn (square 5))

findExpressionStartPosition = (editor, fromPosition) ->
  range = [[0,0], fromPosition]
  position = null
  depth = 0

  editor.displayBuffer.tokenizedBuffer.backwardsIterateTokensInBufferRange range, (token, startPosition, opts) ->
    if isExpressionStart(token)
      if depth == 0
        position = startPosition
        opts.stop()
      else
        depth -= 1
    else if isExpressionEnd(token)
      depth += 1

  position

findExpressionEndPosition = (editor, fromPosition) ->
  range = [fromPosition, editor.buffer.getEndPosition()]
  position = null
  depth = 0

  editor.displayBuffer.tokenizedBuffer.iterateTokensInBufferRange range, (token, startPosition, opts) =>
    if isExpressionEnd(token)
      if depth == 0
        position = startPosition
        opts.stop()
      else
        depth -= 1
    else if isExpressionStart(token)
      depth += 1

  if position
    position = movePositionByCount 1, position, editor.buffer

  position

isExpressionStart = (token) ->
  _.last(token.scopes) == 'punctuation.section.expression.begin.clojure' and token.value == '('

isExpressionEnd = (token) ->
  _.last(token.scopes) == 'punctuation.section.expression.end.clojure' and token.value == ')'

movePositionByCount = (count, position, buffer) ->
  buffer.positionForCharacterIndex(buffer.characterIndexForPosition(position) + count)
