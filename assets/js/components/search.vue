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
        <div class="results" v-if="results.length">
            <div class="result" v-for="result in results" :key="result.id">
                {{ result.title }}
                <p class="description">
                    {{ result.overview }}
                </p>
            </div>
        </div>
    </div>
</template>

<script>
// TODO: should extract this logic to a repository
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
            console.log('need to fire off search for: ', this.query);
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
            })
            .catch((error) => {
                console.log('error: ', error);
            });
        },
    },
}
</script>
