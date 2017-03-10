'use strict';
var app = require('../../server/server');

module.exports = function (Dive) {

    /**
     * Find the planned dives for the given country.
     * @param country the country for which the dives should be returned
     * @param cb      callback function, for asynchronous access. First parameter is the error (or null if none),
     * the second parameter is the result.
     */
    Dive.divesByCountry = function (country, cb) {
        var Location = app.models.location;

        Location.find({fields: ["id"], where: {location: country}}, function (err, locations) {
            var locationIds = [];
            for (var i = 0, length = locations.length; i < length; i++) {
                locationIds.push(locations[i].id);
            }
            Dive.find({where: {location_id: {"inq": locationIds}}}, cb);
        })
    };

    Dive.remoteMethod('divesByCountry', {
        accepts: {arg: 'country', type: 'string'},
        returns: {arg: 'dives', type: 'Dive[]'}
    });
};
