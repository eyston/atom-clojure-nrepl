# atom-clojure-nrepl package

This is a work in progress to add nrepl integration for clojure development in atom.

The goal is to support only clojure and nrepl -- not be a general repl package.

Basic support is working for lein projects.  If you start the repl (which creates the `.nrepl-port` file) and open atom with the project.clj as the base directory it can find the port to connect to the repl and evaluate expressions.

The keybinds are:

- `ctrl-enter` : evaluates the last expression (place your cursor after the closing paren)
- `shift-ctrl-enter` : evaluates the whole file

I want the keybinds to replace `ctrl` with `cmd` but I'm not sure how to make `cmd-enter` override the existing behavior and not ignore mine.  Oh well!

Todos:

- figure out how to get one of those sweet animated gifs showing the plugin in action evaluating clojure omg
- update the nrepl-client I'm using to display print and error values, right now they don't come back and the result is just the expression evaluation value
- add error messaging ... there is none currently (lol)
- add the ability to evaluate the containing expression so that you can evaluate anywhere inside an expression and it will expand out to the largest containing expression
- add some UI niceties like the port number and expression evaluation feedback (green, red, spinner, etc)
- add a clear to the repl buffer or maybe limit it to X messages or something

We'll see if nay of this gets done, woop woop.
