
Template.posts.created = ->
  
  # 1. Initialize

  @loaded = new ReactiveVar(0)
  @limit  = new ReactiveVar(5)
  @ready  = new ReactiveVar(false)

  $(window).on "scroll", (e) =>
    if $(window).scrollTop() + $(window).height() >= $(document).height()
      if Counts.get('posts') > @limit.get() and @ready.get()
        toastr.info('Get more posts')
        console.log("Get more posts", @posts().count(), Counts.get('posts'))
        @limit.set(@limit.get() + 5)

  # 2. Autorun

  @autorun =>

    limit = @limit.get()
    console.log("Asking for #{limit} posts…")

    subscription = Meteor.subscribe('posts', limit)

    if subscription.ready()
      console.log("> Received #{limit} posts. \n\n")
      @loaded.set(limit)
      @ready.set(true)
    else
      @ready.set(false)
      console.log("> Subscription is not ready yet. \n\n")

  # 3. Cursor

  @posts = =>
    Posts.find {},
      limit: @loaded.get()


Template.posts.destroyed = ->
  $(window).off("scroll", scrollWatch)


Template.posts.helpers
  initialLoad: ->
    Template.instance().loaded.get() is 0

  posts: ->
    Template.instance().posts()

  isReady: ->
    Template.instance().ready.get()
    
  hasMorePosts: ->
    Template.instance().posts().count() >= Template.instance().limit.get()


Template.posts.events
  #'click .load-more': (e, tmpl) ->
  #  e.preventDefault()
  #  tmpl.limit.set(tmpl.limit.get() + 5)

  #'scroll window': (e, tmpl) ->
  #  console.log("scroll", $(window).scrollTop() + $(window).height(), $(document).height())




