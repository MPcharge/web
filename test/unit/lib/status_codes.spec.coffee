st = require '../../../lib/status_codes.coffee'

describe 'http status codes', ->

    it 'should map correctly from numeric codes to strings', ->
        expect(st[200]).toEqual 'OK'
        expect(st[403]).toEqual 'Forbidden'
        expect(st[404]).toEqual 'Not Found'
        expect(st[500]).toEqual 'Internal Server Error'

    it 'should map correctly the other way too', ->
        expect(st.OK).toEqual 200
        expect(st.FORBIDDEN).toEqual 403
        expect(st.NOT_FOUND).toEqual 404
        expect(st.INTERNAL_SERVER_ERROR).toEqual 500
