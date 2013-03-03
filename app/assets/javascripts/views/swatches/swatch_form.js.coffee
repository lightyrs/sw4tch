class Sw4tch.Views.SwatchForm extends Backbone.View

  el: 'form.simple_form'

  initialize: ->
    @initTags()
    @initEditor()
    @initActions()
    @attachResize()
    @interceptSubmit()

  initTags: ->
    new Sw4tch.Views.SwatchTags()

  initEditor: ->
    new Sw4tch.Views.SwatchEditor()

  initActions: ->
    new Sw4tch.Views.SwatchActions()

  attachResize: =>
    @_window().on 'resize', @resizeEditor
    @resizeEditor()

  interceptSubmit: ->
    if Sw4tch.Constants.BodyClass is 'swatches-show'
      @$el.bind 'submit', (e) -> e.preventDefault()

  resizeEditor: =>
    @_editor().height( @_window().height() - @_editor().position().top - 50 )

  _editor: -> @$("#editor")

  _window: -> $(window)
