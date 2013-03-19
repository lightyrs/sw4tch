class Sw4tch.Routers.App extends Backbone.Router

  routes:
    '': 'index'
    'swatches': 'index'
    'swatchbooks(/:id)': 'index'
    'dashboard': 'index'
    'users/:id': 'index'
    'swatches/new': 'new'
    'swatches/:id': 'show'
    'swatches/:id/edit': 'edit'

  index: ->
    if $('body').hasClass 'swatches-create' or $('body').hasClass 'swatches-update'
      new Sw4tch.Views.SwatchesShow()
    else
      new Sw4tch.Views.SwatchesIndex()
      @tabs()

  new: ->
    new Sw4tch.Views.SwatchesShow()

  show: ->
    new Sw4tch.Views.SwatchesShow()

  edit: ->
    new Sw4tch.Views.SwatchesShow()

  tabs: ->
    $('#swatches_tab').on 'shown', (e) =>
      new Sw4tch.Views.SwatchesIndex(el: '#swatches')
    $('#swatchbooks_tab').on 'shown', (e) =>
      new Sw4tch.Views.SwatchesIndex(el: '#swatchbooks')
