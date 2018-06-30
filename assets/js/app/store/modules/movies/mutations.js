export default {
    setWatchlist(state, movies) {
        state.watchlist = movies;
    },

    setIsWatchlistLoading(state, isLoading) {
        state.isWatchlistLoading = isLoading;
    }
}