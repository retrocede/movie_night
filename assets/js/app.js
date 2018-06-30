// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";
import Vue from 'vue';
import VueRouter from 'vue-router';
import RootComponent from './root';
import AppRoutes from './app/routes';

//
// Boot up global utils
//
require('./app/boot');

//
// Create router
//
const router = new VueRouter({
    mode: 'history',
    routes: AppRoutes.routes,
});

//
// pull in vuex store
//
import store from './app/store';


//
// Create root vue instance
//
new Vue({
    el: '#app',
    render: h => h(RootComponent),
    router,
    store,
});