class Sw4tch.Routers.App extends Backbone.Router

  routes:
    'swatches/new': 'new'
    'swatches/:id': 'show'
    'swatches/:id/edit': 'edit'

  new: ->
    new Sw4tch.Views.SwatchEditor()

  show: ->
    new Sw4tch.Views.SwatchEditor()

  edit: ->
    new Sw4tch.Views.SwatchEditor()
