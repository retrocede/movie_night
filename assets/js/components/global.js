import buttonComponent from './button';
import carouselComponent from './carousel';
import paginationComponent from './pagination';
import searchComponent from './search';
import spinnerComponent from './spinner';
import movieCardcomponent from './movie_card';

//
// global component registration
//
export default {
    'v-button': buttonComponent,
    'v-carousel': carouselComponent,
    'v-movie-card': movieCardcomponent,
    'v-pagination': paginationComponent,
    'v-search': searchComponent,
    'v-spinner': spinnerComponent,
}
