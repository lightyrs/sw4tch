class Sw4tch.Views.SwatchSwatchbookButton extends Backbone.View

  el: '.btn-group.swatchbook-button'

  initialize: ->
    @attachEvents()

  attachEvents: ->
    @onSwatchbookSelect()

  onSwatchbookSelect: ->
    @$('.dropdown-menu li > a').on 'click', (e) =>
      @addToSwatchbook( @$(e.target).data('swatchbook') )
      e.preventDefault()

  addToSwatchbook: (swatchbookId)->
    action = @$el.parents('form').attr('action')
    $.ajax
      url: "#{action}/swatchbook/#{swatchbookId}/add"
      type: 'get'
      success: (data) =>
        @onAddToSwatchbookSuccess(data)
      error: @onAddToSwatchbookFailure
      beforeSend: =>
        @$('span.text').text('Adding...')

  onAddToSwatchbookSuccess: (data) ->

  onAddToSwatchbookFailure: ->
    # console.log('failure')