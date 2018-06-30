import { getWatchlist } from '../../../repositories/watchlist';

export default {
    fetchWatchlist({ commit }) {
        commit('setIsWatchlistLoading', true);

        const request = getWatchlist();

        request.then(({ data }) => {
            commit('setWatchlist', data);
            commit('setIsWatchlistLoading', false);
        });

        request.catch((error) => {
            console.log('error: ', data);
            commit('setIsWatchlistLoading', false);
        });

        return request;
    },
}