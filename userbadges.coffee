crypto = require 'crypto'
restler = require 'restler'

# Generate a SHA1 hash of an input string
sha1 = (data) ->
    crypto.createHash('sha1').update(data).digest 'hex'

# Add a ts and signature parameter to a map of parameters, and
# return the new set of parameters
signed = (secret, params) ->
    params.ts = Math.floor(Date.now() / 1000.0)

    keys = []
    for own key, value of params
        keys.push key if key isnt 'signature'
    
    sorted = keys.sort().map((key) -> "#{key}=#{params[key]}").join('&')
    
    params.signature = sha1(sorted + secret)
    params

class exports.Client
    # Create a new UserBadges.com API Client
    # The API secret is from your UserBadges.com account
    constructor: (@secret, @endpoint = 'http://api.userbadges.com') ->

    # Get a list of badges for a service / user
    getBadges: (options, callback) ->
        path = "/v1/badges/#{options.service}"
        if options.user
            path += "/#{options.user}"
        path += '.json'

        query = {}

        if options.sort
            query.sort = options.sort

        restler.get(@endpoint + path, query: query).on 'complete', (data, response) ->
            if response.statusCode isnt 200
                throw "#{response.statusCode}: #{data}"
            callback data
        return

    # Add a list of badges to a user on a particular service
    putBadges: (options, callback) ->
        path = "/v1/badges/#{options.service}/#{options.user}.json"

        params = signed @secret,
            badges: options.badges?.join ','

        restler.put(@endpoint + path, data: params).on 'complete', (data, response) ->
            if response.statusCode isnt 200
                throw "#{response.statusCode}: #{data}"
            callback data
        return

    # Remove a list of badges from a user on a particular service
    delBadges: (options, callback) ->
        path = "/v1/badges/#{options.service}/#{options.user}.json"

        params = signed @secret,
            badges: options.badges?.join ','

        restler.del(@endpoint + path, data: params).on 'complete', (data, response) ->
            if response.statusCode isnt 200
                throw "#{response.statusCode}: #{data}"
            callback data
        return

    # Get a list of users for a particular service / badge
    getUsers: (options, callback) ->
        path = "/v1/users/#{options.service}"
        if options.badge
            path += "/#{options.badge}"
        path += '.json'

        query = {}

        if options.sort
            query.sort = options.sort

        restler.get(@endpoint + path, query: query).on 'complete', (data, response) ->
            if response.statusCode isnt 200
                throw "#{response.statusCode}: #{data}"
            callback data
        return
