
Template.loading.rendered = ->
  @loading = window.pleaseWait
    logo: ''
    backgroundColor: '#2980b9'
    loadingHtml: """
      <p class="loading-message">Loading Posts</p>
      <div class="sk-spinner sk-spinner-wandering-cubes">
        <div class="sk-cube1"></div><div class="sk-cube2"></div>
      </div>
      """
  


Template.loading.destroyed = ->
  @loading.finish()