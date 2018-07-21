<style lang="scss" scoped>
    .poster-carousel {
        display: flex;
        flex-direction: column;
        flex-wrap: wrap;
        justify-content: center;
        align-items: center;

        .filters {
            margin-top: 12px;

            .inactive {
                text-decoration: none;
                color: black;
                cursor: pointer;
            }

            .active {
                font-weight: bold;
                user-select: none;
            }
        }

        .cards {
            display: flex;
            flex-wrap: wrap;
        }
    }

    .controls {
        display: flex;
        flex-direction: row;
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
            <div class="filters">
                <span class="active" v-if="filter === 'all'">all</span>
                <a class="inactive" v-else href="#" @click="setFilter('all')">all</a> |
                <span class="active" v-if="filter === 'unwatched'">unwatched</span>
                <a class="inactive" v-else href="#" @click="setFilter('unwatched')">unwatched</a>
            </div>
            <div class="cards">
                <v-movie-card
                    v-for="movie in filteredWatchlist"
                    :key="movie.id"
                    :name="movie.title"
                    :status="movie.status"
                    :poster='movie.poster'
                    :release='movie.release_date'
                    @watch="updateMovieStatus({movie, status: 'watched'})"
                    @unwatch="updateMovieStatus({movie, status: 'unwatched'})"
                    @remove="removeMovie(movie)"/>
            </div>
        </div>
        <div class="controls">
            <v-button @click="random">random</v-button>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
import { mapState, mapActions, mapGetters, mapMutations } from 'vuex';

export default {
    created() {
        this.fetchWatchlist();
    },

    computed: {
        ...mapState('movies', [
            'watchlist',
            'isWatchlistLoading',
            'filter',
        ]),

        ...mapGetters('movies', [
            'filteredWatchlist'
        ]),
    },

    methods: {
        ...mapActions('movies', [
            'fetchWatchlist',
            'updateMovieStatus',
            'removeMovie',
        ]),

        ...mapMutations('movies', [
            'setFilter',
        ]),

        random() {
            let unwatched = this.watchlist.filter((film) => film.status !== 'watched');
            let max = unwatched.length - 1;
            let min = 0;
            let filmIndex = Math.floor( Math.random() * (max - min + 1)) + min;

            alert(`Watch: ${unwatched[filmIndex].title}`);
        },
    },
}
</script>
