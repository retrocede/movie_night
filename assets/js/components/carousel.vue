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
    },
}
</script>
