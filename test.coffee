assert = require 'assert'
restler = require 'restler'
userbadges = require './userbadges'

dummy =
    on: (event, callback) ->
        return

client = new userbadges.Client()

describe 'Get badges', ->
    it 'Should get all badges for a service', ->
        restler.get = (path, options) ->
            assert.equal path, 'http://api.userbadges.com/v1/badges/test.json'
            assert.equal options.query.sort, '-name'
            dummy

        client.getBadges service: 'test', sort: '-name', () -> return

    it 'Should get all badges for a user', ->
        restler.get = (path, options) ->
            assert.equal path, 'http://api.userbadges.com/v1/badges/test/daniel.json'
            assert.equal options.query.sort, undefined
            dummy

        client.getBadges service: 'test', user: 'daniel', () -> return

    it 'Should update badges for a user', ->
        restler.put = (path, options) ->
            assert.equal path, 'http://api.userbadges.com/v1/badges/test/daniel.json'
            assert.equal options.data.badges, 'test1,test2'
            dummy

        client.putBadges service: 'test', user: 'daniel', badges: ['test1', 'test2'], () -> return

    it 'Should delete badges for a user', ->
        restler.del = (path, options) ->
            assert.equal path, 'http://api.userbadges.com/v1/badges/test/daniel.json'
            assert.equal options.data.badges, 'test1,test2'
            dummy

        client.delBadges service: 'test', user: 'daniel', badges: ['test1', 'test2'], () -> return

describe 'Get users', ->
    it 'Should get all users for a service', ->
        restler.get = (path, options) ->
            assert.equal path, 'http://api.userbadges.com/v1/users/test.json'
            assert.equal options.query.sort, '-count'
            dummy

        client.getUsers service: 'test', sort: '-count', () -> return

    it 'Should get all users for a badge', ->
        restler.get = (path, options) ->
            assert.equal path, 'http://api.userbadges.com/v1/users/test/test1.json'
            assert.equal options.query.sort, 'name'
            dummy

        client.getUsers service: 'test', badge: 'test1', sort: 'name', () -> return
