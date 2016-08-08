class App.Collection extends Backbone.Collection
_.extend App.Collection.prototype, App.Mixins.FilterableCollection
_.extend App.Collection.prototype, App.Mixins.SortableCollection