class Sw4tch.Views.SwatchSwatchbookButton extends Backbone.View

  el: '.swatchbook-button'

  initialize: ->
    @attachEvents()

  attachEvents: ->
    @onSwatchbookSelect()
    @onNewSwatchbookSelect()

  onSwatchbookSelect: ->
    @$('li.swatchbook > a').on 'click', (e) =>
      @addToSwatchbook(@$(e.target).data('swatchbook')) unless @$(e.target).data('has-swatch')
      e.preventDefault()

  onNewSwatchbookSelect: ->
    @$('.new-swatchbook-link').on 'click', (e) =>
      @newSwatchbook()
      return false

  addToSwatchbook: (swatchbookId) ->
    $.ajax
      url: "#{@formAction()}/swatchbook/#{swatchbookId}/add"
      type: 'get'
      success: (data) =>
        @onAddToSwatchbookSuccess(data)
      error: =>
        @onAddToSwatchbookFailure()
      beforeSend: =>
        @$('span.text').text('Adding...')

  onAddToSwatchbookSuccess: (data) ->
    @$('span.text').text('Swatchbook')

  onAddToSwatchbookFailure: ->
    @$('span.text').text('Swatchbook')

  newSwatchbook: ->
    $('.dropdown-menu:eq(1)').addClass('active').find('input').focus()
    @$('.submit-swatchbook').one 'click', (e) =>
      @createSwatchbook()
      e.preventDefault()

  createSwatchbook: ->
    name = @$('#swatchbook_name').val()
    if name.length
      $.ajax
        url: "/users/#{Sw4tch.Constants.UserId}/swatchbooks"
        type: 'post'
        data: { 'swatchbook': { 'name': name } }
        success: (data) =>
          @onCreateSwatchbookSuccess(data)
        error: =>
          @onCreateSwatchbookFailure()

  onCreateSwatchbookSuccess: (data) ->
    console.log data
    @addToSwatchbook(data.swatchbookId)
    @$('.btn i').show()

  onCreateSwatchbookFailure: ->
    console.log 'failure'

  swatchId: ->
    @formAction().split('/').pop()

  formAction: ->
    @$el.parents('form').attr('action')