class Sw4tch.Views.SwatchTags extends Backbone.View

  el: '.control-group.tags'

  initialize: =>
    @tagsField().tagsInput
      height: '28px'
      width: '97%'
      minChars: 3
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