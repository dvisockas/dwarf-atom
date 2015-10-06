DwarfView = require './dwarf-view'
{CompositeDisposable} = require 'atom'

http = require "http"
url = require "url"

module.exports = Dwarf =
  dwarfView: null
  modalPanel: null
  subscriptions: null

  qqq: ->
    editor = atom.workspace.getActivePaneItem()
    handler: (req, res) ->
      # require('remote').getCurrentWindow().toggleDevTools()
      res.setHeader 'Access-Control-Allow-Origin', '*'
      res.setHeader 'Access-Control-Request-Method', '*'
      res.setHeader 'Access-Control-Allow-Methods', 'OPTIONS, GET'
      res.setHeader 'Access-Control-Allow-Headers', '*'
      parts = url.parse(req.url, true);
      query = parts.query;
      editor.insertText(query['append'])
      res.end("Yo")
    server = http.createServer()
    server.addListener 'request', handler
    server.listen 9911



  activate: (state) ->
    atom.commands.add 'atom-workspace', "dwarf:qqq", => @qqq()


  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @dwarfView.destroy()

  serialize: ->
    dwarfViewState: @dwarfView.serialize()

  toggle: ->
    console.log 'Dwarf was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
