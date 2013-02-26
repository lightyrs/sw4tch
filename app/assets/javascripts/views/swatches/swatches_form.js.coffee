class Sw4tch.Views.SwatchesForm extends Backbone.View

  el: 'form.simple_form'

  initialize: ->
    @attachTagsInput()

  attachTagsInput: =>
    @tagsField().tagsInput
      height: '28px'
      width: 'auto'
      defaultText: ''
      onAddTag: @onAddTag

  onAddTag: (tagText) =>
    @tagsField().removeTag(tagText) if @tagCount() >= 4

  tagCount: ->
    @tagsList().find('span.tag').length

  tags: ->
    @tagsList().find('span.tag')

  tagsList: ->
    @$('#swatch_tag_list_tagsinput')

  tagsField: ->
    @$('#swatch_tag_list')
