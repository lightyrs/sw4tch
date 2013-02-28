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
    if $('body').hasClass 'swatches-create' or $('body').hasClass 'swatches-update'
      new Sw4tch.Views.SwatchesEditor()
      new Sw4tch.Views.SwatchesForm()
    else
      new Sw4tch.Views.SwatchesIndex()

  new: ->
    new Sw4tch.Views.SwatchesEditor()
    new Sw4tch.Views.SwatchesForm()

  show: ->
    new Sw4tch.Views.SwatchesEditor()
    new Sw4tch.Views.SwatchesForm()

  edit: ->
    new Sw4tch.Views.SwatchesEditor()
    new Sw4tch.Views.SwatchesForm()
