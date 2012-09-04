# Launches the server with the appropriate request handler

server = require './lib/server'

port = process.env.PORT or 5000

# stub until I have routing and resources and all follows

# add `setTimeout` to simulate some long-running async operation
handle = (req, res) ->
    setTimeout ( -> res.writeHead 200; res.end 'hello world'),
               if req.url == '/long' then 3000 else 47

server.run handle, port
