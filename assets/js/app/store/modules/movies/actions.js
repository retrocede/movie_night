import { 
    getWatchlist, 
    updateMovieStatus,
    removeMovie,
} from '../../../repositories/watchlist';

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
    }
}