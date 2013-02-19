class Sw4tch.Views.SwatchEditor extends Backbone.View

  el: '#content'

  initialize: ->
    @initializeAce()
    @initializeEvents()
    @initializePreview()

  initializeAce: ->
    @editor()
    @initAceOptions()
    @initAceContent()

  initializeEvents: ->
    @onSessionChange()

  initializePreview: ->
    @previewBody().setAttribute 'tabindex', 0
    @renderPreview()

  onSessionChange: ->
    @session().on 'change', (e) =>
      @renderPreview() if e.data.text == ';'

  editor: ->
    ace.edit 'editor'

  session: ->
    @editor().getSession()

  formInput: ->
    @$('#swatch_markup')

  previewFrame: ->
    @$('iframe.swatch-frame')[0]

  previewDoc: ->
    @previewFrame().contentDocument || @previewFrame().contentWindow.document

  previewBody: ->
    @previewDoc().body

  previewHTML: ->
    "<h3>previewHTML</h3>\r\n#{@sessionMarkup()}"

  renderPreview: ->
    @previewBody().innerHTML = @previewHTML()

  initAceOptions: ->
    @editor().setBehavioursEnabled false
    @editor().setTheme 'ace/theme/chrome'
    @session().setMode 'ace/mode/css'
    @session().setTabSize 2
    @session().setUseWorker false

  initAceContent: ->
    @session().setValue @formInput().val()
    @editor().moveCursorToPosition(row: 1, column: 2)

  sessionMarkup: ->
    @session().getValue()
