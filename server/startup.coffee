Meteor.startup ->
  max = 25
  if Posts.find().count() < max
    for i in [0...max]
      Posts.insert
        user: Fake.user
          fields: ['name', 'username', 'fullname', '', 'emails.address']
        title: Fake.sentence(6)
        body: Fake.paragraph(3)
      