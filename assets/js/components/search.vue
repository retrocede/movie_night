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
                v-model="query" 
                @keyup.enter="search"
                />
            <v-button @click="search">
                <i class="material-icons">search</i>
            </v-button>
        </div>

        <v-spinner v-if="isLoading" />

        <div class="results" v-if="results.length">
            <v-pagination 
                v-if="pages > 1"
                :currentPage="currentPage"
                :pages="pages"
                @previous="previous"
                @next="next"/>
            <div class="result" v-for="result in results" :key="result.id">
                <div class="result-header">
                    {{ result.title }}
                    <v-button @click="addMovie(result.id)"> + </v-button>
                </div>
                <p class="description">
                    {{ result.overview }}
                </p>
            </div>
            <v-pagination 
                v-if="pages > 1"
                :currentPage="currentPage"
                :pages="pages"
                @previous="previous"
                @next="next"/>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data() {
        return {
            isLoading: false,
            query: '',
            results: [],
            pages: 1,
            currentPage: 1,
        };
    },
    methods: {
        search() {
            this.results = [];
            this.isLoading = true;
            axios.get(`/api/search`, {
                params: {
                    query: encodeURIComponent(this.query),
                    page: this.currentPage,
                }
            })
            .then((response) => {
                console.log('search results: ', response.data);
                this.results = response.data.results;
                this.pages = response.data.pages;
                this.currentPage = response.data.page;
                this.isLoading = false;
            })
            .catch((error) => {
                console.log('error: ', error);
                this.isLoading = false;
            });
        },
        previous() {
            this.currentPage--;
            this.search();
        },
        next() {
            this.currentPage++;
            this.search();
        },
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
