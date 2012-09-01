{ get } = require 'http'

port = process.env.PORT or 5000
base = "http://localhost:#{port}"

describe 'the hello world server I just committed', ->

    it 'should respond with 200 OK', (done) ->
        get base+'/', (res) ->
            expect(res.statusCode).toEqual 200
            done()
