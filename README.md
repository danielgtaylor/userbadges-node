UserBadges Client - Node.js [![Dependency Status](https://gemnasium.com/danielgtaylor/userbadges-node.png)](https://gemnasium.com/danielgtaylor/userbadges-node) [![Build Status](https://travis-ci.org/danielgtaylor/userbadges-node.png)](https://travis-ci.org/danielgtaylor/userbadges-node)
===========================
A UserBadges.com Javascript API client for Node.js.

 * [UserBadges.com API Documentation](http://www.userbadges.com/api/documentation)

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

var client = new userbadges.Client('my-secret-key');
```

Then you can start making calls:

```javascript
# Get a list of badges for the 'test' service sorted reverse alphabetically
client.getBadges({service: 'test', sort: '-name'}, function (data) {
   console.log(data); 
});

# Update a user with badges
client.putBadges({service: 'test', user: 'daniel', badges: ['test1', 'test2']}, function (data) {
   console.log(data); 
});
```

Reference
---------
The following methods are available:

### Client.prototype.getBadges (options, callback)
Get a list of badges for a service or user. The callback should take a single `data` parameter, which is the returned JSON object from the API call. The `options` object can contain:

 * `service` Service name; required
 * `user` User name; optional
 * `sort` Sort method; optional and one of `name`, `-name`, `count`, `-count`, `date`, `-date`

Note: the `count` sorts are only available when no `user` is specified, and the `date` sorts are only available when a `user` is specified.

### Client.prototype.putBadges (options, callback)
Update a user's list of badges. The callback should take a single `data` parameter, which is the returned JSON object from the API call. The `options` object can contain:

 * `service` Service name; required
 * `user` User name; required
 * `badges` Array of badge names to add; required

### Client.prototype.delBadges (options, callback)
Delete badges from a user's list of badges. The callback should take a single `data` parameter, which is the returned JSON object from the API call. The `options` object can contain:

 * `service` Service name; required
 * `user` User name; required
 * `badges` Array of badge names to remove; required

### Client.prototype.getUsers (options, callback)
Get a list of users for a service or badge. The callback should take a single `data` parameter, which is the returned JSON object from the API call. The `options` object can contain:

 * `service` Service name; required
 * `badge` Badge name; optional
 * `sort` Sort method; optional and one of `name`, `-name`, `count`, `-count`, `date`, `-date`

License
-------
Copyright (c) 2013 Daniel G. Taylor

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
