class Sw4tch.Views.SwatchesForm extends Backbone.View

  el: 'form.simple_form'

  initialize: ->
    @attachTagsInput()

  attachTagsInput: =>
    @tagsField().tagsInput
      height: '28px'
      width: 'auto'
      minChars: 2
      maxChars: 28
      defaultText: ''
      onAddTag: @onAddTag

  onAddTag: (tagText) =>
    if @tagCount() >= 4
      @tagsField().removeTag(tagText)
      @$('small.help-text').css('color', 'red')
    else
      @$('small.help-text').css('color', 'inherit')

  tagCount: ->
    @tagsList().find('span.tag').length

  tags: ->
    @tagsList().find('span.tag')

  tagsList: ->
    @$('#swatch_tag_list_tagsinput')

  tagsField: ->
    @$('#swatch_tag_list')
