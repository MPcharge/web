# Handles incoming and outgoing representations of documents

# Parses incoming requests into documents/objects.
exports.mparse = (req, res, callback) ->
    parsers =
        'application/x-www-form-urlencoded': (require 'querystring').parse
        'application/json': JSON.parse

    parse = parsers[req.headers['content-type']] or -> data: body, type: req.headers['content-type']
    
    req.setEncoding 'utf-8'; body = ''; req.on 'data', (chunk) -> body += chunk  # body is short
    req.on 'end', -> callback (parse body)

# Renders the given object into a response.
# TODO templating and formats and languages and everything
exports.render = (req, res, obj) ->
    obj.statusCode ?= 200  # default to OK if not specified
    res.writeHead obj.statusCode, 'Content-Type': 'application/json'
    delete obj.statusCode  # we don't need that in the body
    res.write JSON.stringify obj unless req.method == 'HEAD'
    res.end '\n\n'
