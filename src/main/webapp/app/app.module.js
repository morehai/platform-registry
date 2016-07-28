(function() {
    'use strict';

    angular
        .module('PlatformRegistryApp', [
            'ngStorage',
            'ngResource',
            'ngCookies',
            'ngAria',
            'ngCacheBuster',
            'ui.bootstrap',
            'ui.router',
            'hljs',
            // platform-needle-angularjs-add-module Platform will add new module here
            'angular-loading-bar'
        ])
        .run(run);

    run.$inject = ['stateHandler'];

    function run(stateHandler) {
        stateHandler.initialize();
    }
})();
