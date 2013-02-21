window.Sw4tch =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Sw4tch.Routers.App
    Backbone.history.start pushState: true
    console.log('Sw4tch.initialize')

$(document).ready ->
  Sw4tch.initialize()
