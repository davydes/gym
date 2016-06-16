class App.Models.JournalItem extends App.RelationalModel
  defaults:
    executed_at: moment().unix()

  relations: [{
    type: 'HasOne'
    key: 'workout'
    relatedModel: 'App.Models.Workout'
  }]