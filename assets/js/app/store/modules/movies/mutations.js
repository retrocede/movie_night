export default {
    setWatchlist(state, movies) {
        state.watchlist = movies;
    },

    setSearchResults(state, movies) {
        state.searchResults = movies;
    },

    setSearchQuery(state, query) {
        state.searchQuery = query;
    },

    setResultsPage(state, page) {
        state.resultsPage = page;
    },

    setResultsPages(state, pages) {
        state.resultsPages = pages;
    },

    setIsWatchlistLoading(state, isLoading) {
        state.isWatchlistLoading = isLoading;
    },

    setIsSearchLoading(state, isLoading) {
        state.isSearchLoading = isLoading;
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
    },

    addMovieToWatchlist(state, movie) {
        state.watchlist.push(movie);
    },

    setFilter(state, filter) {
        state.filter = filter;
    },
}