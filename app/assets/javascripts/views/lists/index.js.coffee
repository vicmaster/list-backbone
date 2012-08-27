class ListBackbone.Views.ListsIndex extends Backbone.View

  template: JST['lists/index']

  render: ->
    $(@el).html(@template(lists: 'Backboneize'))
    this
