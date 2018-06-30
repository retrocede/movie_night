<style lang="scss" scoped>
    .movie {
        display: flex;
        justify-content: center;
        align-items: center;

        .watched {
            text-decoration: line-through;
        }
    }

    .poster-carousel {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        align-items: center;
    }
</style>

<template>
    <div class="carousel">
        <div class="loading" v-if="isWatchlistLoading">
            <v-spinner />
        </div>
        <div class="poster-carousel" v-else>
            <v-movie-card
                v-for="movie in watchlist"
                :key="movie.id"
                :name="movie.title"
                :status="movie.status"
                :poster='movie.poster'
                :release='movie.release_date'
                @watch="updateMovieStatus({movie, status: 'watched'})"
                @unwatch="updateMovieStatus({movie, status: 'unwatched'})"
                @remove="removeMovie(movie)"/>
        </div>
        <v-button @click="random">random</v-button>
    </div>
</template>

<script>
import axios from 'axios';
import { mapState, mapActions } from 'vuex';

export default {
    created() {
        this.fetchWatchlist();
    },

    computed: {
        ...mapState('movies', [
            'watchlist',
            'isWatchlistLoading',
        ]),
    },

    methods: {
        ...mapActions('movies', [
            'fetchWatchlist',
            'updateMovieStatus',
            'removeMovie',
        ]),

        random() {
            let unwatched = this.watchlist.filter((film) => film.status !== 'watched');
            let max = unwatched.length - 1;
            let min = 0;
            let filmIndex = Math.floor( Math.random() * (max - min + 1)) + min;

            alert(`Watch: ${unwatched[filmIndex].title}`);
        },
        // removeMovie(movie) {
        //     axios.delete(`/api/movies/${ movie.id }`)
        //     .then((result) => {
        //         this.fetchMovies();
        //     })
        //     .catch((error) => {
        //         console.log('error: ', error);
        //     });
        // },
    },
}
</script>
