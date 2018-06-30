import { 
    getWatchlist, 
    updateMovieStatus,
    removeMovie,
} from '../../../repositories/watchlist';
import { searchForMovie } from '../../../repositories/search';

export default {
    fetchWatchlist({ commit }) {
        commit('setIsWatchlistLoading', true);

        const request = getWatchlist();

        request.then(({ data }) => {
            commit('setWatchlist', data);
            commit('setIsWatchlistLoading', false);
        });

        request.catch((error) => {
            // TODO: implement erorr handling
            console.log('error: ', error);
            commit('setIsWatchlistLoading', false);
        });

        return request;
    },

    updateMovieStatus({ commit }, { movie, status }) {
        const request = updateMovieStatus(movie, status);

        request.then(({ data }) => {
            commit('setMovieStatus', { movie, status });
        });

        request.catch((error) => {
            // TODO: implement erorr handling
            console.log('error: ', error);
        });

        return request;
    },

    removeMovie({ commit }, movie) {
        const request = removeMovie(movie);

        request.then(({ data }) => {
            commit('removeMovieFromWatchlist', movie);
        });

        request.catch((error) => {
            // TODO:  implement error handling
            console.log('error: ', error);
        });

        return request;
    },

    searchForMovie({ commit, state }) {
        commit('setIsSearchLoading', true);

        var page = state.resultsPage;
        var query = state.searchQuery;

        const request = searchForMovie(query, page);

        request.then(({ data }) => {
            // set pages
            commit('setResultsPages', data.pages);
            // set page
            commit('setResultsPage', data.page);
            // set results
            commit('setSearchResults', data.results);
            commit('setIsSearchLoading', false);
        });

        request.catch((error) => {
            // TODO:  implement error handling
            console.log('error: ', error);
            commit('setIsSearchLoading', false);
        });

        return request;
    },

    nextPage({ commit, state, dispatch }) {
        var page = state.resultsPage;
        var pages = state.resultsPages;

        if (page < pages) {
            commit('setResultsPage', page + 1);
            dispatch('searchForMovie');
        }
    },

    prevPage({ commit, state, dispatch }) {
        var page = state.resultsPage;
        var pages = state.resultsPages;

        if (page > 1) {
            commit('setResultsPage', page - 1);
            dispatch('searchForMovie');
        }
    },
}