crypto = require 'crypto'
restler = require 'restler'

sha1 = (data) ->
    crypto.createHash('sha1').update(data).digest 'hex'

signed = (secret, params) ->
    params.ts = Math.floor(Date.now() / 1000.0)

    keys = []
    for own key, value of params
        keys.push key if key isnt 'signature'
    
    sorted = keys.sort().map((key) -> "#{key}=#{params[key]}").join('&')
    
    params.signature = sha1(sorted + secret)
    params

class exports.Client
    constructor: (@secret, @endpoint = 'http://api.userbadges.com') ->

    getBadges: (options, callback) ->
        path = "/v1/badges/#{options.service}"
        if options.user
            path += "/#{options.user}"
        path += '.json'

        query = {}

        if options.sort
            query.sort = options.sort

        restler.get(@endpoint + path, query: query).on 'complete', (data, response) ->
            callback data
        return

    putBadges: (options, callback) ->
        path = "/v1/badges/#{options.service}/#{options.user}.json"

        params = signed @secret,
            badges: options.badges.join ','

        restler.put(@endpoint + path, data: params).on 'complete', (data, response) ->
            callback data
        return

    delBadges: (options, callback) ->
        path = "/v1/badges/#{options.service}/#{options.user}.json"

        params = signed @secret,
            badges: options.badges.join ','

        restler.del(@endpoint + path, data: params).on 'complete', (data, response) ->
            callback data

    getUsers: (options, callback) ->
        path = "/v1/users/#{options.service}"
        if options.badge
            path += "/#{options.badge}"
        path += '.json'

        query = {}

        if options.sort
            query.sort = options.sort

        restler.get(@endpoint + path, query: query).on 'complete', (data, response) ->
            callback data
