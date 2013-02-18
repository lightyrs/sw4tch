class Sw4tch.Models.SwatchMarkup extends Backbone.Model

  urlRoot: '/markup'

  url: ->
    "#{@urlRoot}/#{@model.from}/#{@model.to}"
