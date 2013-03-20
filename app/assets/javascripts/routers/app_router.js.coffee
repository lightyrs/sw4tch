class Sw4tch.Routers.App extends Backbone.Router

  routes:
    '' : 'homeIndex'
    'swatches/new': 'swatchesNew'
    'swatches/:id': 'swatchesShow'
    'swatches/:id/edit': 'swatchesEdit'
    'swatches': 'swatchesIndex'
    'swatchbooks': 'swatchbooksIndex'
    'swatchbooks/:id': 'swatchbooksShow'
    'dashboard': 'usersShow'
    'users/:id': 'usersShow'

  before: (route) ->
    @initTabs()

  homeIndex: ->
    return @resourceView() if @failedPost()
    @collectionView '#swatches'

  swatchesNew: ->
    @resourceView()

  swatchesShow: ->
    @resourceView()

  swatchesEdit: ->
    @resourceView()

  swatchesIndex: ->
    @collectionView '#swatches'

  swatchbooksShow: ->
    @collectionView '#swatches'

  swatchbooksIndex: ->
    @collectionView '#swatchbooks'

  usersShow: ->
    @collectionView '#swatches'

  resourceView: ->
    new Sw4tch.Views.SwatchesShow()

  collectionView: (container) ->
    new Sw4tch.Views.SwatchesIndex(el: container)

  initTabs: ->
    $('#swatches_tab').on 'shown', (e) =>
      new Sw4tch.Views.SwatchesIndex(el: '#swatches')
    $('#swatchbooks_tab').on 'shown', (e) =>
      new Sw4tch.Views.SwatchesIndex(el: '#swatchbooks')

  failedPost: ->
    $('body').hasClass 'swatches-create' or $('body').hasClass 'swatches-update'
