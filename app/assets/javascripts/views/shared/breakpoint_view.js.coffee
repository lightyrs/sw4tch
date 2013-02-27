class Sw4tch.Views.BreakpointView extends Backbone.View

  initialize: ->
    @initBreakpoint()

  initBreakpoint: ->
    @_window().setBreakpoints
      breakpoints: [767]
    @_window().on 'enterBreakpoint767', @enterBreakpoint767
    @_window().on 'exitBreakpoint767', @exitBreakpoint767

  enterBreakpoint767: =>
    @_editor().parents('.editor-wrapper').appendTo('.editor-column')

  exitBreakpoint767: =>
    @_editor().parents('.editor-wrapper').insertAfter('.swatch-container')

  _window: -> $(window)

  _editor: -> $('#editor')