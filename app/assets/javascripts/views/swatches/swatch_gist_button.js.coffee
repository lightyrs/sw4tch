class Sw4tch.Views.SwatchGistButton extends Backbone.View

  el: '.btn-group.gist-button'

  initialize: ->
    @attachEvents()

  attachEvents: ->
    @onGistSyntaxSelect()
    @onGistPublicSelect()

  onGistSyntaxSelect: ->
    @$('.dropdown-menu li > a').on 'click', (e) =>
      $('.dropdown-menu').dropdown('toggle')
      @$(e.target).text('Public?').end().parents('li').addClass('public-setting')
      e.preventDefault()

  onGistPublicSelect: ->
    @$('.dropdown-menu li .btn-group a').on 'click', (e) =>
      target = @$(e.target)
      syntax = target.parents('.btn-group').siblings('a').data('syntax')
      label = target.parents('.btn-group').siblings('a').data('label')
      isPublic = target.data('public')

      target.parents('li').removeClass('public-setting').find('> a').text(label)
      @createGist(syntax, isPublic)

  createGist: (syntax, isPublic) ->
    action = @$el.parents('form').attr('action')
    $.ajax
      url: "#{action}/gist/#{syntax}/#{isPublic}"
      type: 'get'
      success: (data) =>
        @onGistSuccess(data)
      error: @onGistFailure
      beforeSend: =>
        @$('span.text').text('Publishing...')

  onGistSuccess: (data) ->
    @$el.find('span.text').text('Publish Gist')
    @$el.siblings('.gist-url').find('a').text(data).attr('href', data).end().show()

  onGistFailure: ->
    @$el.find('span.text').text('Publish Gist')
