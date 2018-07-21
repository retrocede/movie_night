export default {
    filteredWatchlist(state) {
        if (state.filter === 'all') {
            return state.watchlist;
        }

        if (state.filter === 'unwatched') {
            return state.watchlist.filter((movie) => movie.status != 'watched');
        }
    }
}