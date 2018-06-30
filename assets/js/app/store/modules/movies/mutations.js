export default {
    setWatchlist(state, movies) {
        state.watchlist = movies;
    },

    setIsWatchlistLoading(state, isLoading) {
        state.isWatchlistLoading = isLoading;
    },

    setMovieStatus(state, { movie, status }) {
        const match = state.watchlist.filter((item) => {
            return item.id == movie.id;
        })[0];

        match.status = status;
    },

    removeMovieFromWatchlist(state, movie) {
        const index = state.watchlist.indexOf(movie);

        state.watchlist.splice(index, 1);
    }
}