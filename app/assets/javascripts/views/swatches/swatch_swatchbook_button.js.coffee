class Sw4tch.Views.SwatchSwatchbookButton extends Backbone.View

  el: '.swatchbook-button'

  initialize: ->
    @attachEvents()

  attachEvents: ->
    @onSwatchbookSelect()
    @onNewSwatchbookSelect()

  onSwatchbookSelect: ->
    @$('li.swatchbook > a').on 'click', (e) =>
      @addToSwatchbook(@$(e.target)) unless @$(e.target).data('has-swatch')
      return false

  onNewSwatchbookSelect: ->
    @$('.new-swatchbook-link').on 'click', (e) =>
      @$(e.target).parents('li').addClass('active')
      @newSwatchbook()
      return false

  addToSwatchbook: (target) ->
    $.ajax
      url: "#{@formAction()}/swatchbook/#{target.data('swatchbook')}/add"
      type: 'get'
      success: (data) =>
        @onAddToSwatchbookSuccess(data)
      error: =>
        @onAddToSwatchbookFailure()
      complete: =>
        target.parents('li').removeClass('active')
      beforeSend: =>
        target.parents('li').addClass('active')

  onAddToSwatchbookSuccess: (data) ->
    @$("[data-swatchbook='#{data.id}']").find('i').attr('class', 'icon-check')
    @dropdownMenu().find('input').val('').focus()

  onAddToSwatchbookFailure: ->
    # console.log 'failure'

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
        beforeSend: =>
        complete: =>
          @dropdownMenu().find('input').parents('li').removeClass('active').
            end().blur().end().removeClass('active')

  onCreateSwatchbookSuccess: (swatchbook) ->
    @appendToMenu swatchbook
    @addToSwatchbook @$("[data-swatchbook='#{swatchbook.id}']")

  onCreateSwatchbookFailure: ->
    # console.log 'failure'

  appendToMenu: (swatchbook) ->
    @menuItemTemplate(swatchbook).insertBefore(@dropdownMenu().find('.divider'))

  menuItemTemplate: (swatchbook) ->
    $("<li class='swatchbook'><span class='ajax-loader'></span><a href='#' data-has-swatch='false' data-swatchbook='#{swatchbook.id}'><i class='icon-check-empty'></i> #{swatchbook.name}</a></li>")

  swatchId: ->
    @formAction().split('/').pop()

  formAction: ->
    @$el.parents('form').attr('action')

  dropdownMenu: ->
    @$('.dropdown-menu')
