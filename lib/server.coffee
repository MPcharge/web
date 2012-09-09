# Provides the server

http = require 'http'

# starts the server
exports.run = (handle, port) ->

    srv = http.createServer (req, res) ->

            ### disabled until the own-domain-with-https problem is solved
            if process.env.FORCE_HTTPS
                if req.headers['x-forwarded-proto']? and req.headers['x-forwarded-proto'] != 'https'
                    res.writeHead 301, 'Location': 'https://'+req.host+req.url
                    res.end()
            else
                handle req, res
            ###
            handle req, res

        .listen port, -> console.log "listening on port #{port}"
