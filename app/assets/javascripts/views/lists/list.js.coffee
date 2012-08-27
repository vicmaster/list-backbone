class ListBackbone.Views.List extends Backbone.View

  tagName: 'li'

  events:
      'click #delete' : 'deleteList'

  template: JST['lists/list']

  render: ->
    $(@el).html(@template(list: @model))
    this

  deleteList: (e)->
      e.preventDefault()
      if confirm('Are you sure?')
        @model.destroy()
