<style lang="scss" scoped>
    .search {
        width: 100%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .result {
        display: block;
        border: 1px solid rgb(53, 61, 53);
        border-radius: 3px;
        padding: 10px;
        margin: 12px 10px;

        .result-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .description {
            font-family: 'Roboto';
        }
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

        <v-spinner v-if="isSearchLoading" />

        <div class="results" v-if="searchResults.length">
            <v-pagination 
                v-if="resultsPages > 1"
                :currentPage="resultsPage"
                :pages="resultsPages"
                @previous="prevPage"
                @next="nextPage"/>
            <div class="result" v-for="result in searchResults" :key="result.id">
                <div class="result-header">
                    {{ result.title }}
                    <v-button @click="addMovie(result.id)"> + </v-button>
                </div>
                <p class="description">
                    {{ result.overview }}
                </p>
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
        ]),

        ...mapMutations('movies', [
            'setSearchQuery'
        ]),

        addMovie(id) {
            console.log('add movie: ', id);
            axios.post('/api/movies', {
                id
            })
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
