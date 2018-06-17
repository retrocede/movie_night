<style lang="scss" scoped>

</style>

<template>
    <div class="carousel">
        <div class="loading" v-if="this.isLoading">
            <v-spinner />
        </div>
        <div class="watchlist" v-else>
            <div class="movie" v-for="movie in movies" :key="movie.api_id">
                {{ movie.title }}
            </div>
        </div>
        <v-button @click="random">random</v-button>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    created() {
        this.fetchMovies();
    },

    data() {
        return {
            isLoading: false,
            movies: [],
        };
    },

    methods: {
        fetchMovies() {
            this.isLoading = true;
            axios.get('/api/movies')
            .then((response) => {
                this.movies = response.data.data; // this is silly, should probably fix it
                this.isLoading = false;
            })
            .catch((error) => {
                console.log('error: ', error);
            });
        },
        random() {
            let max = this.movies.length - 1;
            let min = 0;
            let filmIndex = Math.floor( Math.random() * (max - min + 1)) + min;

            alert(`Watch: ${this.movies[filmIndex].title}`);
        }
    },
}
</script>
