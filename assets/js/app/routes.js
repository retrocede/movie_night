import HomeComponent from '../pages/home/home';
import AboutComponent from '../pages/about/about';
import PageNotFoundComponent from '../pages/404/404';

export default {
    routes: [
        //
        // Home
        //
        {
            path: '/',
            name: 'home',
            component: HomeComponent,
            meta: {
                title: 'Home Page',
            }
        },

        //
        // About
        //
        {
            path: '/about',
            name: 'about',
            component: AboutComponent,
            meta: {
                title: 'About Page'
            },
        },

        //
        // 404
        //
        {
            path: '*',
            component: PageNotFoundComponent,
            meta: {
                title: 'Page not found',
            },
        },
    ],
}