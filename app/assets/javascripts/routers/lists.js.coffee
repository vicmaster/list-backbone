class ListBackbone.Routers.Lists extends Backbone.Router
  routes:
    '' : 'index'
    'lists/:id': 'show'

  initialize: ->
    @collection = new ListBackbone.Collections.Lists()
    @collection.fetch()

  index: ->
    view = new ListBackbone.Views.ListsIndex(collection: @collection)
    $('#container').html(view.render().el)

  show:(id) ->
    alert "hello #{id}"
