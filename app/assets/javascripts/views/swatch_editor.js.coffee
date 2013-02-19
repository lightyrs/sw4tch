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
    @onTabShown()

  initializePreview: ->
    @previewBody().setAttribute 'tabindex', 0
    @renderPreview()

  onSessionChange: ->
    @session().on 'change', (e) =>
      @renderPreview() if e.data.text == ';'

  onTabShown: ->
    @$('a[data-toggle="tab"]').on 'shown', (e) =>
      @inputToSession()

  editor: ->
    ace.edit 'editor'

  session: ->
    @editor().getSession()

  cssInput: ->
    @$('#swatch_css')

  scssInput: ->
    @$('#swatch_scss')

  stylusInput: ->
    @$('#swatch_stylus')

  activeTab: ->
    @$('.nav-tabs .active a').attr 'href'

  activeInput: ->
    switch @activeTab()
      when '#tab_css' then @cssInput()
      when '#tab_scss' then @scssInput()
      when '#tab_stylus' then @stylusInput()
      else null

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
    @inputToSession()
    @editor().moveCursorToPosition(row: 1, column: 2)

  inputToSession: ->
    @session().setValue @activeInput().val()

  sessionMarkup: ->
    @session().getValue()
