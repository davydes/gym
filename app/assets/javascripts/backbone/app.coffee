#= require_self

#= require_tree ./templates

#= require ./mixins/base/mixin
#= require_tree ./mixins/base
#= require_tree ./mixins

#= require ./models/base/model
#= require_tree ./models/base
#= require_tree ./models

#= require ./collections/base/collection
#= require_tree ./collections/base
#= require_tree ./collections

#= require      ./views/base/view
#= require_tree ./views/base
#= require_tree ./views

#= require      ./routers/base/router
#= require_tree ./routers/base
#= require_tree ./routers

#= require_tree ./others

@App  =
  Mixins: {}
  Models: {}
  Collections: {}
  Routers: {}
  Views:
    Journals:
      Items: {}
    Workouts:
      Items: {}
    Pictures:
      Manage: {}
      Dialog: {}
    Shared:
      Components: {}

_.extend App, Backbone.Events
