class ListBackbone.Views.ListsIndex extends Backbone.View

  template: JST['lists/index']

  events:
    'submit #new_list': 'createList'

  initialize: ->
    @collection.on('reset',@render, this)
    @collection.on('add',@appendList, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendList)
    this

  appendList: (list) ->
    view = new ListBackbone.Views.List(model: list)
    $('#lists').append(view.render().el)

  createList: (e)->
    e.preventDefault()
    @collection.create name: $('#new_list_name').val(), description:  $('#new_list_description').val()
    $('#new_list')[0].reset()
