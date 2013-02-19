class Sw4tch.Views.SwatchEditor extends Backbone.View

  el: '#content'

  template: JST['swatch_preview']

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
      @toggleSyntax(e)

  toggleSyntax: (e) ->
    @inputToSession()
    @setSessionMode @activeSyntax()

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

  activeSyntax: ->
    @activeTab().replace '#tab_', ''

  activeInput: ->
    switch @activeSyntax()
      when 'css' then @cssInput()
      when 'scss' then @scssInput()
      when 'stylus' then @stylusInput()
      else null

  previewFrame: ->
    @$('iframe.swatch-frame')[0]

  previewDoc: ->
    @previewFrame().contentDocument || @previewFrame().contentWindow.document

  previewBody: ->
    @previewDoc().body

  previewTemplate: ->
    @template(customCSS: @sessionMarkup())

  renderPreview: ->
    @previewBody().innerHTML = @previewTemplate()

  initAceOptions: ->
    @editor().setBehavioursEnabled false
    @editor().setTheme 'ace/theme/chrome'
    @setSessionMode('css')
    @session().setTabSize 2
    @session().setUseWorker false

  initAceContent: ->
    @inputToSession()
    @editor().moveCursorToPosition(row: 1, column: 2)

  inputToSession: ->
    @session().setValue @activeInput().val()

  setSessionMode: (syntax) ->
    @session().setMode "ace/mode/#{syntax}"

  sessionMarkup: ->
    @session().getValue()
