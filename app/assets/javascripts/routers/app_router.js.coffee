class Sw4tch.Routers.App extends Backbone.Router

  routes:
    '': 'index'
    'swatches': 'index'
    'dashboard': 'index'
    'users/:id': 'index'
    'swatches/new': 'new'
    'swatches/:id': 'show'
    'swatches/:id/edit': 'edit'

  index: ->
    new Sw4tch.Views.SwatchesIndex()
    if $('body').hasClass 'swatches-create' or $('body').hasClass 'swatches-update'
      new Sw4tch.Views.SwatchesEditor()

  new: ->
    new Sw4tch.Views.SwatchesEditor()

  show: ->
    new Sw4tch.Views.SwatchesEditor()

  edit: ->
    new Sw4tch.Views.SwatchesEditor()
