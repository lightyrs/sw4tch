class Sw4tch.Views.SwatchSwatchbookButton extends Backbone.View

  el: '.btn-group.swatchbook-button'

  initialize: ->
    @attachEvents()

  attachEvents: ->
    @onSwatchbookSelect()
    @onNewSwatchbookSelect()

  onSwatchbookSelect: ->
    @$('.dropdown-menu li.swatchbook > a').on 'click', (e) =>
      @addToSwatchbook(@$(e.target).data('swatchbook')) unless @$(e.target).data('has-swatch')
      e.preventDefault()

  onNewSwatchbookSelect: ->
    @$('.dropdown-menu li.new-swatchbook > a').on 'click', (e) =>
      @newSwatchbook()
      return false

  addToSwatchbook: (swatchbookId) ->
    action = @$el.parents('form').attr('action')
    $.ajax
      url: "#{action}/swatchbook/#{swatchbookId}/add"
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
    $('.dropdown-menu:eq(1)').addClass('active').dropdown('toggle').find('input').focus()
    @$('.btn').on 'click', (e) =>
      @createSwatchbook()
      e.preventDefault()

  createSwatchbook: ->
    name = @$('#swatchbook_name').val()
    if name.length
      $.ajax
        url: "/users/#{Sw4tch.Constants.UserId}/swatchbooks"
        type: 'post'
        success: (data) =>
          @onCreateSwatchbookSuccess(data)
        error: =>
          @onCreateSwatchbookFailure()

  onCreateSwatchbookSuccess: (data) ->
    console.log 'success'

  onCreateSwatchbookFailure: ->
    console.log 'failure'

