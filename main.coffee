# Launches the server with the appropriate request handler and resources

server  = require './lib/server'
routing = require './lib/routing'

port = process.env.PORT or 5000

server.run (routing.createHandler './index'), port
