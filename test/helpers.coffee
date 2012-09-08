describe 'path behavior', ->

    path = require '../helpers/path'

    it 'should canonicalize paths', ->
        expect(path.createPath '//ab/cd////ef//g').toEqual '/ab/cd/ef/g/'
        expect(path.createPath '//abSSScd/SS/ef//gS', 'S').toEqual '//abScd/S/ef//gS'
        expect(path.createPath 'abcd').toEqual 'abcd/'
