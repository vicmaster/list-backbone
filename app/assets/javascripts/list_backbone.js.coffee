window.ListBackbone =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new ListBackbone.Routers.Lists()
    Backbone.history.start()

$(document).ready ->
  ListBackbone.init()
