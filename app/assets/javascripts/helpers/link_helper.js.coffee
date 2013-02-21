Handlebars.registerHelper "link", (text, url, target='', className='') ->

  text = Handlebars.Utils.escapeExpression(text)
  url = Handlebars.Utils.escapeExpression(url)
  target = Handlebars.Utils.escapeExpression(target)
  className = Handlebars.Utils.escapeExpression(className)

  result = "<a class=\"" + className + "\" href=\"" + url + "\" target=\"" + target + "\">" + text + "</a>"

  new Handlebars.SafeString(result)
