class Sw4tch.Views.SwatchesForm extends Backbone.View

  el: 'form.simple_form'

  initialize: ->
    @attachTagsInput()

  attachTagsInput: =>
    @tagsField().tagsInput
      height: '28px'
      width: '100%'
      defaultText: ''
      onAddTag: @onAddTag

  onAddTag: (tagText) =>
    @tagsField().removeTag(tagText) if @tagCount() >= 4

  tagCount: ->
    @$('#swatch_tag_list_tagsinput').find('span.tag').length

  tagsField: ->
    @$('#swatch_tag_list')
