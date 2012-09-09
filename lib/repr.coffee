# Handles incoming and outgoing representations of documents

# Parses incoming requests into documents/objects.
exports.mparse = (req, res, callback) ->
    parsers =
        'application/x-www-form-urlencoded': (require 'querystring').parse
        'application/json': JSON.parse

    parse = parsers[req.headers['content-type']] or -> data: body, type: req.headers['content-type']
    
    req.setEncoding 'utf-8'; body = ''; req.on 'data', (chunk) -> body += chunk  # body is short
    req.on 'end', -> callback (if body then parse body else null)

# Renders the given object into a response.
# TODO templating and formats and languages and everything
exports.render = (req, res, obj) ->
    obj.statusCode ?= 200  # default to OK if not specified
    obj.headers ?= {}; obj.headers['Content-Type'] = 'application/json'
    res.writeHead obj.statusCode, obj.headers
    delete obj.statusCode; delete obj.headers  # we don't need that in the body
    res.write JSON.stringify obj unless req.method in ['HEAD','OPTIONS']
    res.end '\n\n'
