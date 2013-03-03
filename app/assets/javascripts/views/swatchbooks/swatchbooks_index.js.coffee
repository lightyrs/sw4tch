class Sw4tch.Views.SwatchbooksIndex extends Backbone.View

  el: '#swatchbooks'

  initialize: ->
    @$el.flipshow()
    @$el.shapeshift(enableDrag: false)
