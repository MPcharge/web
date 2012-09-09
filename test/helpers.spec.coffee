describe 'path behavior', ->

    path = require '../helpers/path'
    mkPath = path.createPath

    it 'should canonicalize paths', ->
        expect(mkPath '//ab/cd////ef//g').toEqual '/ab/cd/ef/g/'
        expect(mkPath '//abSSScd/SS/ef//gS', 'S').toEqual '//abScd/S/ef//gS'
        expect(mkPath 'a/b/c/d').toEqual mkPath 'a///b/c//d/'
