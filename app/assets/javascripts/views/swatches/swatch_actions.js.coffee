class Sw4tch.Views.SwatchActions extends Backbone.View

  el: '.form-actions'

  initialize: ->
    new Sw4tch.Views.SwatchGistButton()
    new Sw4tch.Views.SwatchSwatchbookButton()