Handlebars.registerHelper "link", (options) ->

  options = options.hash

  text = Handlebars.Utils.escapeExpression(options.text)
  url = Handlebars.Utils.escapeExpression(options.url)
  target = Handlebars.Utils.escapeExpression(options.target)
  className = Handlebars.Utils.escapeExpression(options.className)

  result = "<a class=\"" + className + "\" href=\"" + url + "\" target=\"" + target + "\">" + text + "</a>"

  new Handlebars.SafeString(result)
