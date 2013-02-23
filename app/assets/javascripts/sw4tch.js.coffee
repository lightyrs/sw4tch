window.Sw4tch =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Sw4tch.Routers.App
    Backbone.history.start pushState: true

$(document).ready ->
  Sw4tch.initialize()
