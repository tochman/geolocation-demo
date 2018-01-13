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
    const element = document.querySelector('body');
    let observer = new MutationObserver(mutations => {
        mutations.forEach(mutation => {
            if (mutation.type === "attributes") {
                console.log("attributes changed");
                initiateMap()
            }
        });
    });

    observer.observe(element, {
        attributes: true //configure it to listen to attribute changes
    });

    getPosition({enableHighAccuracy: true})
        .then(position => {
            setCookie('geocoderLocation', JSON.stringify(position.coords))
                .then(() => {
                    redirectWithLocation();
                    document.body.dataset.geocoded = true;
                })
                .catch(error => console.log(error))
        })
        .catch(error => console.log(error))
});


getPosition = (options) => {
    if (document.body.dataset.env === 'test') {
        return new Promise((resolve) => {
            let fakePosition = JSON.parse(document.getElementById('fake_position').content);
            resolve({coords: {latitude: fakePosition.lat, longitude: fakePosition.lng}})
        })
    } else {
        return new Promise((resolve, reject) => {
            navigator.geolocation.getCurrentPosition(
                position => resolve(position),
                error => reject(error),
                options
            );

        });
    }
};

redirectWithLocation = () => {
    let url = new URL(window.location.href);
    if (document.body.dataset.geocoded !== 'true') {
        window.location.replace(url);
    }
};

setCookie = (name, value, days = 7, path = '/') => {
    return new Promise(resolve => {
        const expires = new Date(Date.now() + days * 864e5).toUTCString();
        document.cookie = name + '=' + encodeURIComponent(value) + '; expires=' + expires + '; path=' + path
        resolve();
    })
};

getCookie = (name) => {
    return new Promise(resolve => {
        const value = document.cookie.split('; ').reduce((r, v) => {
            const parts = v.split('=');
            return parts[0] === name ? decodeURIComponent(parts[1]) : r
        }, '');
        resolve(value);
    })
};



