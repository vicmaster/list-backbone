class ListBackbone.Views.ListsIndex extends Backbone.View

  template: JST['lists/index']

  events:
    'submit #new_list': 'createList'

  initialize: ->
    @collection.on('reset',@render, this)
    @collection.on('add',@appendList, this)
    @collection.on('remove',@removeOneList, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendList)
    this

  appendList: (list) ->

    listId = if list.id? list.id else list.cid
    elementId = 'list-' + listId
    view = new ListBackbone.Views.List(model: list, id: elementId)
    $('#lists').append(view.render().el)

  createList: (e)->
    e.preventDefault()
    attributes = name: $('#new_list_name').val(), description:  $('#new_list_description').val()
    @collection.create attributes,
      wait: true
      success: -> $('#new_list')[0].reset()
      error: @handleError

  handleError: (list, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{messages}" for message in messages

  removeOneList: (e) ->
      listId = if e.id? e.id else e.cid
      @$el.find('#list-' + listId).remove()
