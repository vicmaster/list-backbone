class ListBackbone.Routers.Lists extends Backbone.Router
  routes:
    '' : 'index'
    'lists/:id': 'show'

  index: ->
    view = new ListBackbone.Views.ListsIndex()
    $('#container').html(view.render().el)

  show:(id) ->
    alert "hello #{id}"
