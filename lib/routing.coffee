# provides routing functionality and handles resources

url  = require 'url'
st   = require './status_codes'
mkPath = (require '../helpers/path').createPath
{ mparse, render } = require './repr'

literal = {}
templated = []  # order matters here
resource = (paths, description, responses_obj) ->
    for path in paths.split ' '
        path = mkPath path
        if (path.indexOf '{') == -1  # it is a literal URL
            literal[path] = { description, responses_obj }
        else
            [ regex, paramsExtractor ] = parseTemplated path
            templated.push { description, responses_obj, regex, paramsExtractor }

templateParamsRegex = /\{([^\/\.]+)(\.\.\.)?\}/g
parseTemplated = (path) ->
    tokens = []
    regex = path.replace templateParamsRegex, (_, token, greedy) ->
        tokens.push token
        if greedy then '(.*)' else '([^/]+)'
    regex = new RegExp '^' + regex + '$'

    paramsExtractor = (path) ->
        values = (path.match regex).slice 1
        params = {}
        for t, i in tokens
            params[t] = values[i]
        params

    [ regex, paramsExtractor ]

findTemplated = (path) ->
    for t in templated
        if t.regex.test path then return [ t, t.paramsExtractor path ]
    return []


exports.createHandler = (index_filename) ->

    global.resource = resource;  # make resource available to index
    require process.cwd()+'/'+index_filename;  # a sophisticated eval :D
    delete global.resource  # and don't pollute global

    # TODO probably should go into its own file as it contains things not at all connected to routing
    respond = (req, res) ->
        path = mkPath (url.parse req.url).path
        respondTo = req.method; if respondTo == 'HEAD' then respondTo = 'GET'

        # TODO handle authorization + GET_ALL here

        matching = literal[path]; params = {}  # literal first
        if not matching then [ matching, params ] = findTemplated path

        if not matching then render req, res, statusCode: st.NOT_FOUND; return
        if not matching.responses_obj[respondTo]
            s = if respondTo == 'OPTIONS' then st.OK else st.METHOD_NOT_ALLOWED
            render req, res, statusCode: s, headers: allowedMethods(matching).join ', '
            return

        mparse req, res, (body) ->
            render req, res, (matching.responses_obj[respondTo] params, body)  # TODO GET_ALL
        
    respond


allowedMethods = (responses_obj) ->
    allow = ['OPTIONS']  # always allowed
    if responses_obj.GET? then allow.push 'HEAD' # implicitly defined by GET
    allow.push m for m of responses_obj
    allow
