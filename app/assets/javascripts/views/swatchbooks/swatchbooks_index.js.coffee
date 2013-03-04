class Sw4tch.Views.SwatchbooksIndex extends Backbone.View

  el: '#swatchbooks'

  initialize: ->
    @$el.find('.swatchbook.fc-slideshow').flipshow()
    @$el.shapeshift(enableDrag: false)
