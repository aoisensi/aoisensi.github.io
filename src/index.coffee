window.Polymer =
  dom: 'shadow'
  lazyRegister: true
do ->
  onload = ->
    if !window.HTMLImports
      document.dispatchEvent new CustomEvent('WebComponentsReady', bubbles: true)

  webComponentsSupported = 'registerElement' of document and 'import' of document.createElement('link') and 'content' of document.createElement('template')
  if !webComponentsSupported
    script = document.createElement('script')
    script.async = true
    script.src = '/components/webcomponentsjs/webcomponents-lite.min.js'
    script.onload = onload
    document.head.appendChild script
  else
    onload()
