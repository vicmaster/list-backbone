class ListBackbone.Views.List extends Backbone.View

  template: JST['lists/list']

  render: ->
    $(@el).html(@template(list: @model))
    this
