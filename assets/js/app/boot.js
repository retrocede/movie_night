import Vue from 'vue';
import components from '../components/global';

//
// Plugins
//
require('./plugins/router');

//
// Register global components
//
Object.keys(components).forEach((name) => {
    Vue.component(name, components[name]);
});