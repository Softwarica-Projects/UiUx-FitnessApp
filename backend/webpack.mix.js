const mix = require('laravel-mix');

mix.js('resources/js/libs.js', 'public/js/libs.min.js')
    .sass('resources/sass/libs.scss','public/css/libs.min.css')
    .sass('public/scss/hope-ui.scss', 'public/css')
    .sass('public/scss/custom.scss', 'public/css')
    .sass('public/scss/customizer.scss', 'public/css')
    .options({
        processCssUrls: false
    });
