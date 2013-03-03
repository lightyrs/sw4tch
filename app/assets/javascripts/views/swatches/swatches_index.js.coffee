class Sw4tch.Views.SwatchesIndex extends Backbone.View

  el: '#swatches'

  template: JST['swatch_preview']

  frame: null

  initialize: ->
    @initializeSwatchbooks()
    @initializePreview(frame) for frame in @previewFrames()
    @$el.shapeshift(enableDrag: false)

  initializeSwatchbooks: ->
    $('a.swatchbooks[data-toggle="tab"]').on 'shown', (e) ->
      new Sw4tch.Views.SwatchbooksIndex()

  initializePreview: (frame) ->
    @frame = frame
    @renderPreview()

  renderPreview: ->
    @previewBody().innerHTML = @previewTemplate()

  previewFrames: ->
    @$('iframe.swatch-frame')

  previewDoc: ->
    @frame.contentDocument || @frame.contentWindow.document

  previewBody: ->
    @previewDoc().body

  previewTemplate: ->
    @template(customCSS: @previewMarkup(), href: @previewLink(), name: @previewName())

  previewMarkup: ->
    $(@frame).data 'css'

  previewLink: ->
    $(@frame).data 'href'

  previewName: ->
    $(@frame).data 'name'
