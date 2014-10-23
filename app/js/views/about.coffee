class App.Views.About extends Snakeskin.StaticView
  name: 'About'

  events:
    'click #buy_beer': 'handlePayPal'

  initialize: (options) ->
    if @$el
      @prevTerms = @$('#search').val()
    @search = _.throttle(@_search, 500)
    @listenTo(@, 'placed', @setupJS)

  cleanup: =>
    $('iframe[src^="https://coinbase.com"]').remove()

  setupJS: =>
    flattrButton = @$('.FlattrButton')
    content = flattrButton.parent()[0]

    gps = @scriptTag()
    gps.src = 'https://grtp.co/v1.js'
    gps.setAttribute('data-gratipay-username','wbond')
    content.insertBefore(gps, flattrButton[0])

    fs = @scriptTag()
    fs.src = '//api.flattr.com/js/0.6/load.js?mode=auto'
    content.insertBefore(fs, flattrButton[0])

    # Disabled due to JS issues with IE
    #cbs = @scriptTag()
    #cbs.src = '//coinbase.com/assets/button.js'
    #content.appendChild(cbs)

  scriptTag: ->
    el = document.createElement('script')
    el.type = 'text/javascript'
    el.async = true
    el

  handlePayPal: ->
    button = @$('#buy_beer')
    button.closest('form').click(->
        $(@).submit()
        return false
    )
