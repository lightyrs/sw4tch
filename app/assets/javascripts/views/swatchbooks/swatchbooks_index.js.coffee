class Sw4tch.Views.SwatchbooksIndex extends Backbone.View

  el: '#swatchbooks'

  initialize: ->
    @$el.shapeshift(enableDrag: false)
