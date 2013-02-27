window.Sw4tch =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Sw4tch.Routers.App
    Backbone.history.start pushState: true
    new Sw4tch.Views.BreakpointView

$(document).ready ->
  Sw4tch.initialize()
