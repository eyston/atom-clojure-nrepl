AtomClojureNrepl = require '../lib/atom-clojure-nrepl'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "AtomClojureNrepl", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('atomClojureNrepl')

  describe "when the atom-clojure-nrepl:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.atom-clojure-nrepl')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'atom-clojure-nrepl:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.atom-clojure-nrepl')).toExist()
        atom.workspaceView.trigger 'atom-clojure-nrepl:toggle'
        expect(atom.workspaceView.find('.atom-clojure-nrepl')).not.toExist()
