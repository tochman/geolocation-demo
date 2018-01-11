// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .

document.addEventListener('turbolinks:load', () => {

    getPosition({enableHighAccuracy: true})
        .then(position => {
            redirectWithLocationParams(position)
        }).catch(error => {
        // What do we do here?
    })


});

getPosition = (options) => {
    return new Promise((resolve, reject) => {
        navigator.geolocation.getCurrentPosition(
            // On Success
            position => {
                resolve(position);
            },
            error => {
                reject(error);
            },
            options
        );

    });
};

redirectWithLocationParams = (position) => {
    let lat = position.coords.latitude,
        lng = position.coords.longitude,
        url = new URL(window.location.href),
        params = {lat: lat, lng: lng};

    Object.keys(params).forEach(key => {
        url.searchParams.append(key, params[key])
    });

    if (document.body.dataset.geocoded !== 'true') {
        document.body.dataset.geocoded = true;
        window.location.replace(url);
    }
};
