UserBadges Client - Node.js [![Dependency Status](https://gemnasium.com/danielgtaylor/userbadges-node.png)](https://gemnasium.com/danielgtaylor/userbadges-node) [![Build Status](https://travis-ci.org/danielgtaylor/userbadges-node.png?branch=master)](https://travis-ci.org/danielgtaylor/userbadges-node)
===========================
A UserBadges.com Javascript API client for Node.js.

 * [UserBadges.com API Documentation](http://www.userbadges.com/api-documentation)

Installation
------------
Install the client library via `npm`:

```bash
npm install userbadges
```

Usage
-----
The client is fairly simple to use, with just a few methods. Start by instantiating a client instance with your API secret key:

```javascript
var userbadges = require('userbadges');

// Create a client with your API key
var client = new userbadges.Client('my-secret-key');

// Or create a client to hit a specific endpoint URL
var client = new userbadges.Client('my-secret-key', 'http://foo.com')
```

Then you can start making calls:

```javascript
// Get a list of badges for the 'test' service sorted reverse alphabetically
client.getServiceBadges({service: 'test', sort: '-name'}, function (data) {
   console.log(data); 
});

// Add a badge type called test2
client.addServiceBadges({service: 'test', badges: [{name: 'test2', description: 'Test description', myCustomField: 'foo'}]});

// Update a user with badges
client.addUserBadges({service: 'test', user: 'daniel', badges: ['test1', 'test2']}, function (data) {
   console.log(data); 
});
```

Reference
---------
The userbadges library has one object available:

### Client (key, [endpoint])
Create a new client instance, optionally giving the endpoint URL to use.

The following methods are available:

### Client.prototype.getServiceBadges (options, callback)
Get a list of badges for a service. The callback should take a single `data` parameter, which is the returned JSON object from the API call. The `options` object can contain:

 * `service` Service name; required
 * `sort` Sort method; optional and one of `name`, `-name`, `count`, `-count`, `date`, `-date`

### Client.prototype.addServiceBadges (options, callback)
Add or update a service's list of badges. The callback should take a single `data` parameter, which is the returned JSON object from the API call. The `options` object can contain:

 * `service` Service name; required
 * `badges` Array of badge objects to add including custom fields; required

### Client.prototype.delServiceBadges (options, callback)
Delete badges from a user's list of badges. The callback should take a single `data` parameter, which is the returned JSON object from the API call. The `options` object can contain:

 * `service` Service name; required
 * `badges` Array of badge names to remove; required

### Client.prototype.getUsers (options, callback)
Get a list of users for a service, optionally filtered by name or badges. The callback should take a single `data` parameter, which is the returned JSON object from the API call. The `options` object can contain:

 * `service` Service name; required
 * `names` Only get uses with these names; optional, comma-seperated list
 * `badges` Only get users with these badges; optional, comma-seperated list
 * `sort` Sort method; optional and one of `name`, `-name`, `count`, `-count`, `date`, `-date`

 ### Client.prototype.addUserBadges (options, callback)
 Add a list of badges to a user by name. The callback should take a single `data` parameter, which is the returned JSON object from the API call. The `options` object can contain:

 * `service` Service name; required
 * `user` User name; required
 * `badges` Comma-seperated list of badge names to add; required

 ### Client.prototype.delUserBadges (options, callback)
Remove a list of badges from a user by name. The callback should take a single `data` parameter, which is the returned JSON object from the API call. The `options` object can contain:

 * `service` Service name; required
 * `user` User name; required
 * `badges` Comma-seperated list of badge names to add; required

Contributing
------------
Contributions are welcome - just fork the project and submit a pull request when you are ready!

### Getting Started
First, create a fork on GitHub. Then:

```bash
git clone ...
cd userbadges-node
npm install
```

### Unit Tests
Before submitting a pull request, please add any relevant tests and run them via:

```bash
npm test
```

Changes that cause tests to fail will not be accepted.

License
-------
Copyright (c) 2013 Daniel G. Taylor

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
