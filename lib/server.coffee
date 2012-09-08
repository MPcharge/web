# Provides the server

http = require 'http'

force_https = false # TODO read from config

# starts the server
#
# handle: the request handler (will receive request & response objects)
# port and hostname: which port and address the server should listen to
# callback: will be called once listening
exports.run = (handle, port) ->

    srv = http.createServer (req, res) ->

            ### disabled until the own-domain-with-https problem is solved
            if force_https
                if req.headers['x-forwarded-proto']? and req.headers['x-forwarded-proto'] != 'https'
                    res.writeHead 301, 'Location': 'https://'+req.host+req.url
                    res.end()
            else
                handle req, res
            ###
            handle req, res

        .listen port, undefined, -> console.log "listening on port #{port}"

    # graceful shutdown
    process.on 'SIGTERM', srv.close  # stop accepting connections, terminate once event queue empty
