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
    @dropdownMenu().addClass('active').find('input').focus()
    @$('.submit-swatchbook').one 'click', (e) =>
      @createSwatchbook()
      e.preventDefault()
      e.stopPropagation()

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

  onCreateSwatchbookSuccess: (swatchbook) ->
    @appendToMenu(swatchbook)
    @addToSwatchbook(swatchbook.id)

  onCreateSwatchbookFailure: ->
    console.log 'failure'

  appendToMenu: (swatchbook) ->
    @menuItemTemplate(swatchbook).insertBefore(@dropdownMenu().find('.divider'))

  menuItemTemplate: (swatchbook) ->
    $("<li class='swatchbook'><a href='#' data-has-swatch='false' data-swatchbook='#{swatchbook.id}'><i class='icon-check'></i> #{swatchbook.name}</a></li>")

  swatchId: ->
    @formAction().split('/').pop()

  formAction: ->
    @$el.parents('form').attr('action')

  dropdownMenu: ->
    @$('.dropdown-menu')
