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
        justify-content: center;
        align-items: center;
    }
</style>

<template>
    <div class="carousel">
        <div class="loading" v-if="this.isLoading">
            <v-spinner />
        </div>
        <div class="watchlist" v-else>
            <div class="movie" v-for="movie in movies" :key="movie.api_id">
                <v-button @click="removeMovie(movie)">X</v-button>
                <div :class="{ watched: movie.status === 'watched'}">{{ movie.title }}</div>
                <v-button v-if="movie.status === 'watched'" @click="updateMovieStatus(movie, 'unwatched')">
                    <i class="material-icons">stop</i>
                </v-button>
                <v-button v-else @click="updateMovieStatus(movie, 'watched')">
                    <i class="material-icons">play_arrow</i>
                </v-button>
            </div>
        </div>
        <v-button @click="random">random</v-button>
        <div class="poster-carousel">
            <v-movie-card
                v-for="movie in movies"
                :key="movie.id"
                :name="movie.title"
                :status="movie.status"
                :poster='movie.poster' />
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
        random() {
            let unwatched = this.movies.filter((film) => film.status !== 'watched');
            let max = unwatched.length - 1;
            let min = 0;
            let filmIndex = Math.floor( Math.random() * (max - min + 1)) + min;

            alert(`Watch: ${unwatched[filmIndex].title}`);
        },
        removeMovie(movie) {
            axios.delete(`/api/movies/${ movie.id }`)
            .then((result) => {
                this.fetchMovies();
            })
            .catch((error) => {
                console.log('error: ', error);
            });
        },
        updateMovieStatus(movie, status) {
            movie.status = status;
            axios.put(`/api/movies/${ movie.id }`, {
                movie
            })
            .then((response) => {
                this.fetchMovies();
            })
            .catch((error) => {
                console.log('error: ', error);
            })
        },
    },
}
</script>
