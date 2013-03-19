class Sw4tch.Routers.App extends Backbone.Router

  routes:
    '': 'index'
    'swatches': 'index'
    'swatchbooks(/*subroute)': 'index'
    'dashboard(/*subroute)': 'index'
    'users/(*subroute)': 'index'
    'swatches/new': 'new'
    'swatches/:id': 'show'
    'swatches/:id/edit': 'edit'

  og_path: ''

  index: (options) ->
    if $('body').hasClass 'swatches-create' or $('body').hasClass 'swatches-update'
      new Sw4tch.Views.SwatchesShow()
    else
      new Sw4tch.Views.SwatchesIndex(el: '#swatches')
      @og_path = window.location.pathname.
                  replace(/(.*)\/swatches$|\/swatchbooks$/, '$1').
                  replace(/\/$/, '').replace(/^\//, '')
      @tabs()
      Backbone.history.navigate("#{@og_path}/swatches")

  new: ->
    new Sw4tch.Views.SwatchesShow()

  show: ->
    new Sw4tch.Views.SwatchesShow()

  edit: ->
    new Sw4tch.Views.SwatchesShow()

  tabs: ->
    $('#swatches_tab').on 'shown', (e) =>
      new Sw4tch.Views.SwatchesIndex(el: '#swatches')
      Backbone.history.navigate("#{@og_path}/swatches")
    $('#swatchbooks_tab').on 'shown', (e) =>
      new Sw4tch.Views.SwatchesIndex(el: '#swatchbooks')
      Backbone.history.navigate("#{@og_path}/swatchbooks")
