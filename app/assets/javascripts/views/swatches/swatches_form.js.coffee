class Sw4tch.Views.SwatchesForm extends Backbone.View

  el: 'form.simple_form'

  initialize: ->
    @attachTagsInput()
    @attachResize()

  attachTagsInput: =>
    @tagsField().tagsInput
      height: '28px'
      width: '97%'
      minChars: 2
      maxChars: 28
      defaultText: ''
      onAddTag: @onAddTag

  attachResize: =>
    @_window().on 'resize', @resizeEditor
    @resizeEditor()

  onAddTag: (tagText) =>
    if @tagCount() >= 4
      @tagsField().removeTag(tagText)
      @$('small.help-text').css('color', 'red')
    else
      @$('small.help-text').css('color', 'inherit')

  resizeEditor: =>
    @_editor().height( @_window().height() - @_editor().position().top - 50 )

  tagCount: ->
    @tagsList().find('span.tag').length

  tags: ->
    @tagsList().find('span.tag')

  tagsList: ->
    @$('#swatch_tag_list_tagsinput')

  tagsField: ->
    @$('#swatch_tag_list')

  _editor: -> @$("#editor")

  _window: -> $(window)
