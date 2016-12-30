Polymer
  is: 'aoisensi-body'
  properties: page:
    type: String
    reflectToAttribute: true
    observer: '_pageChanged'
  observers: [ '_routePageChanged(routeData.page)' ]
  _routePageChanged: (page) ->
    @page = page or 'index'
    if !@$.drawer.persistent
      @$.drawer.close()

  _pageChanged: (page) ->
    resolvedPageUrl = @resolveUrl('aoisensi-' + page + '.html')
    @importHref resolvedPageUrl, null, null, true
