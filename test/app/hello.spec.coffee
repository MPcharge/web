{ get } = require 'http'

port = process.env.PORT or 5000
base = "http://localhost:#{port}"

describe 'the hello world server I just committed', ->

    it 'should respond with 200 OK and say "hello world"', (done) ->
        get base+'/', (res) ->
            res.setEncoding 'utf8'; body = ''; res.on 'data', (chunk) -> body += chunk
            res.on 'end', ->
                expect(res.statusCode).toEqual 200
                expect(body).toEqual 'hello world'
                done()
