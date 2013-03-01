crypto = require 'crypto'
restler = require 'restler'

# Generate a SHA1 hash of an input string
sha1 = (data) ->
    crypto.createHash('sha1').update(data).digest 'hex'

# Add a ts and signature parameter to a map of parameters, and
# return the new set of parameters
signed = (secret, path, params, body) ->
    params.ts = Math.floor(Date.now() / 1000.0)
    params.signature = sha1(secret + params.ts + path + body)
    params

class exports.Client
    # Create a new UserBadges.com API Client
    # The API secret is from your UserBadges.com account
    constructor: (@secret, @endpoint = 'http://api.userbadges.com') ->

    # Get a list of badges for a service
    getServiceBadges: (options, callback) ->
        path = "/v1/#{options.service}/badges.json"

        query = {}

        if options.sort
            query.sort = options.sort

        restler.get(@endpoint + path, query: query).on 'complete', (data, response) ->
            if response.statusCode isnt 200
                throw "#{response.statusCode}: #{data}"
            callback? data
        return

    # Add a list of badges to a service
    addServiceBadges: (options, callback) ->
        path = "/v1/#{options.service}/badges.json"

        body = JSON.stringify
            badges: options.badges

        params = signed @secret, path, {}, body

        restler.put(@endpoint + path, headers: {'Content-Type': 'application/json'}, query: params, data: body).on 'complete', (data, response) ->
            if response.statusCode isnt 200
                throw "#{response.statusCode}: #{data}"
            callback? data
        return

    # Remove a list of badges from a user on a particular service
    delServiceBadges: (options, callback) ->
        path = "/v1/#{options.service}/badges.json"

        body = JSON.stringify
            badges: options.badges

        params = signed @secret, path, {}, body

        restler.del(@endpoint + path, headers: {'Content-Type': 'application/json'}, query: params, data: body).on 'complete', (data, response) ->
            if response.statusCode isnt 200
                throw "#{response.statusCode}: #{data}"
            callback? data
        return

    # Get a list of users for a particular service / badge
    getUsers: (options, callback) ->
        path = "/v1/#{options.service}/users.json"

        query = {}

        if options.names
            query.names = options.names

        if options.sort
            query.sort = options.sort

        restler.get(@endpoint + path, query: query).on 'complete', (data, response) ->
            if response.statusCode isnt 200
                throw "#{response.statusCode}: #{data}"
            callback? data
        return

    addUserBadges: (options, callback) ->
        path = "/v1/#{options.service}/users/#{options.user}.json"

        body = JSON.stringify
            badges: options.badges

        params = signed @secret, path, {}, body

        restler.put(@endpoint + path, headers: {'Content-Type': 'application/json'}, query: params, data: body).on 'complete', (data, response) ->
            if response.statusCode isnt 200
                throw "#{response.statusCode}: #{data}"
            callback? data
        return

    delUserBadges: (options, callback) ->
        path = "/v1/#{options.service}/users/#{options.user}.json"

        body = JSON.stringify
            badges: options.badges

        params = signed @secret, path, {}, body

        restler.del(@endpoint + path, headers: {'Content-Type': 'application/json'}, query: params, data: body).on 'complete', (data, response) ->
            if response.statusCode isnt 200
                throw "#{response.statusCode}: #{data}"
            callback? data
        return
