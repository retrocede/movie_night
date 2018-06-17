<style lang="scss" scoped>

</style>

<template>
    <div class="carousel">
        watchlist goes here
        <p> {{ movies }} </p>
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
            movies: [],
        };
    },

    methods: {
        fetchMovies() {
            axios.get('/api/movies')
            .then((response) => {
                console.log('response: ', response.data);
            })
            .catch((error) => {
                console.log('error: ', error);
            });
        },
    },
}
</script>
