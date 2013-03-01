class Sw4tch.Views.SwatchesShow extends Backbone.View

  initialize: ->
    @initForm()

  initForm: ->
    new Sw4tch.Views.SwatchForm()