class Sw4tch.Views.SwatchesForm extends Backbone.View

  el: 'form.simple_form'

  initialize: ->
    @attachTagsInput()

  attachTagsInput: ->
    @tagsField().tagsInput()

  tagsField: ->
    @$('#swatch_tag_list')
