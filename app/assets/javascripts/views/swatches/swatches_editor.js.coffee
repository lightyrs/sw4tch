class Sw4tch.Views.SwatchesEditor extends Backbone.View

  el: '#content'

  template: JST['swatch_preview']

  freshestSyntax: null

  freshestMarkup: null

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
    @onTabShow()
    @onTabShown()

  initializePreview: ->
    @previewBody().setAttribute 'tabindex', 0
    @renderPreview()

  onSessionChange: ->
    @textarea().on 'keyup', (e) =>
      @updateActiveInput()
      @renderPreview() if @renderWasTriggered(e)

  onTabShow: ->
    @$('a[data-toggle="tab"]').on 'show', (e) =>
      @freshestSyntax = @activeSyntax()
      @freshestMarkup = @activeInput().val()

  onTabShown: ->
    @$('a[data-toggle="tab"]').on 'shown', (e) =>
      @toggleSyntax(e)
      @compileMarkup(@freshestSyntax, @activeSyntax(), @freshestMarkup)

  updateActiveInput: ->
    @updateInputWith @activeInput(), @sessionMarkup()

  updateInputWith: (input, markup) ->
    input.val markup

  renderWasTriggered: (e) ->
    if @isCSS() then return true
    if @isSCSS() and e.keyCode is 186 then return true
    if @isStylus() and e.keyCode is 13 then return true
    false

  toggleSyntax: (e) ->
    @setSessionMode @activeSyntax()

  editor: ->
    ace.edit 'editor'

  session: ->
    @editor().getSession()

  textarea: ->
    @$('.ace_text-input')

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

  isCSS: ->
    @activeSyntax() is 'css'

  isSCSS: ->
    @activeSyntax() is 'scss'

  isStylus: ->
    @activeSyntax() is 'stylus'

  needsCompile: ->
    _.include ['scss', 'stylus'], @activeSyntax()

  previewFrame: ->
    @$('iframe.swatch-frame')[0]

  previewDoc: ->
    @previewFrame().contentDocument || @previewFrame().contentWindow.document

  previewBody: ->
    @previewDoc().body

  previewTemplate: (css = null) ->
    @template(customCSS: css, href: @previewLink(), name: @previewName())

  previewCSS: ->
    @cssInput().val()

  renderPreview: (data = null) ->
    if @isCSS()
      @renderMarkup()
    else if data
      @renderData(data)
    else
      @compileMarkup()

  renderMarkup: ->
    @previewBody().innerHTML = @previewTemplate @sessionMarkup()

  renderData: (data) ->
    @previewBody().innerHTML = @previewTemplate data

  initAceOptions: ->
    @editor().setBehavioursEnabled false
    @editor().setTheme 'ace/theme/chrome'
    @setSessionMode('css')
    @session().setTabSize 2
    @session().setUseWorker false

  initAceContent: ->
    @inputToSession()

  inputToSession: ->
    @session().setValue @activeInput().val()

  setSessionMode: (syntax) ->
    @session().setMode "ace/mode/#{syntax}"

  sessionMarkup: =>
    @session().getValue()

  compileMarkup: (from = @activeSyntax(), to = 'css', markup = @sessionMarkup()) ->
    console.log(markup)
    $.ajax
      url: "/markup/compile/#{from}/#{to}"
      data: markup: "#{markup}"
      type: 'post'
      success: (data) =>
        @onCompileSuccess(data, to)
      error: @onCompileFailure

  onCompileSuccess: (data, to) =>
    @updateInputWith(@$("#swatch_#{to}"), data)
    @inputToSession()
    @renderPreview @previewCSS()

  onCompileFailure: ->
    console.log 'failure'

  previewLink: ->
    $(@previewFrame()).data 'href'

  previewName: ->
    $(@previewFrame()).data 'name'
