assert = require 'assert'
restler = require 'restler'
userbadges = require './userbadges'

dummy =
    on: (event, callback) ->
        return

exception =
    on: (event, callback) ->
        callback 'Not Found!', statusCode: 404

client = new userbadges.Client('abc123')

describe 'Services', ->
    it 'Should get all badges for a service', ->
        restler.get = (path, options) ->
            assert.equal path, 'http://api.userbadges.com/v1/test/badges.json'
            assert.equal options.query.sort, '-name'
            dummy

        client.getServiceBadges service: 'test', sort: '-name', () -> return

    it 'Should add badges to a service', ->
        restler.put = (path, options) ->
            assert.equal path, 'http://api.userbadges.com/v1/test/badges.json'
            assert.ok options.query.ts
            assert.ok options.query.signature
            assert.equal options.data, JSON.stringify badges: [name: 'test1', description: 'foo']
            dummy

        client.addServiceBadges service: 'test', badges: [name: 'test1', description: 'foo'], () -> return

    it 'Should delete badges from a service', ->
        restler.delete = (path, options) ->
            assert.equal path, 'http://api.userbadges.com/v1/test/badges.json'
            assert.ok options.query.ts
            assert.ok options.query.signature
            assert.equal options.data, JSON.stringify badges: ['test1']
            dummy

        client.delServiceBadges service: 'test', badges: ['test1'], () -> return

describe 'Users', ->
    it 'Should get all badges for a user', ->
        restler.get = (path, options) ->
            assert.equal path, 'http://api.userbadges.com/v1/test/users.json'
            assert.equal options.query.names, 'daniel'
            assert.equal options.query.sort, undefined
            dummy

        client.getUsers service: 'test', names: ['daniel'], () -> return

    it 'Should add badges to a user', ->
        restler.put = (path, options) ->
            assert.equal path, 'http://api.userbadges.com/v1/test/users/daniel.json'
            assert.ok options.query.ts
            assert.ok options.query.signature
            assert.equal options.data, JSON.stringify badges: ['test1']
            dummy

        client.addUserBadges service: 'test', user: 'daniel', badges: ['test1'], () -> return

    it 'Should remove badges from a user', ->
        restler.delete = (path, options) ->
            assert.equal path, 'http://api.userbadges.com/v1/test/users/daniel.json'
            assert.ok options.query.ts
            assert.ok options.query.signature
            assert.equal options.data, JSON.stringify badges: ['test1']
            dummy

        client.delUserBadges service: 'test', user: 'daniel', badges: ['test1'], () -> return

describe 'Exception', ->
    it 'Should throw when HTTP status is not 200', ->
        restler.get = (path, options) ->
            exception

        request = () ->
            client.getServiceBadges service: 'test', () -> return

        assert.throws request, '404 - Not Found!'
