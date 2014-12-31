
Meteor.publish 'posts', (limit) ->
  Meteor._sleepForMs(2000)
  Counts.publish @, 'posts', Posts.find(),
    noReady: true
  Posts.find {},
    limit: limit
