<style lang="scss" scoped>
    .search {
        width: 100%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .results { 
        min-height: 500px;
    }

    .movies {
        width: 100%;
        flex-wrap: wrap;
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
    }
</style>

<template>
    <div class="search">
        <div>
            <input 
                type="text" 
                class="search-input" 
                placeholder="Movie Title Search"
                :value="searchQuery" 
                @input="setSearchQuery($event.target.value)"
                @keyup.enter="searchForMovie"
                />
            <v-button @click="searchForMovie">
                <i class="material-icons">search</i>
            </v-button>
        </div>


        <div class="results" v-if="searchResults.length">
            <v-pagination 
                v-if="resultsPages > 1"
                :currentPage="resultsPage"
                :pages="resultsPages"
                @previous="prevPage"
                @next="nextPage"/>
            <v-spinner v-if="isSearchLoading" />
            <div class="movies" v-else>
                <v-movie-card v-for="movie in searchResults"
                    :key="movie.id"
                    :name="movie.title"
                    status="search"
                    :poster='`https://image.tmdb.org/t/p/w154${movie.poster_path}`'
                    :release='movie.release_date'
                    :search-result='true'
                    @add="addMovie(movie.id)"/>
            </div>
            <v-pagination 
                v-if="resultsPages > 1"
                :currentPage="resultsPage"
                :pages="resultsPages"
                @previous="prevPage"
                @next="nextPage"/>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
import { mapState, mapActions, mapMutations } from 'vuex';

export default {
    computed: {
        ...mapState('movies', [
            'searchQuery',
            'searchResults',
            'resultsPage',
            'resultsPages',
            'isSearchLoading',
        ]),
    },
    methods: {
        ...mapActions('movies', [
            'searchForMovie',
            'nextPage',
            'prevPage',
            'addMovie',
        ]),

        ...mapMutations('movies', [
            'setSearchQuery'
        ]),
    },
}
</script>
