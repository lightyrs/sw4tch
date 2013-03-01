class Sw4tch.Views.SwatchForm extends Backbone.View

  el: 'form.simple_form'

  initialize: ->
    @initTags()
    @initEditor()
    @attachResize()

  initTags: ->
    new Sw4tch.Views.SwatchTags()

  initEditor: ->
    new Sw4tch.Views.SwatchEditor()

  attachResize: =>
    @_window().on 'resize', @resizeEditor
    @resizeEditor()

  resizeEditor: =>
    @_editor().height( @_window().height() - @_editor().position().top - 50 )

  _editor: -> @$("#editor")

  _window: -> $(window)
