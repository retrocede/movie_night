<style lang="scss" scoped>
    .pagination {
        margin: 10px 12px;
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .current {
        margin: 10px 12px;
    }
</style>

<template>
    <div class="pagination">
        <v-button 
            class="previous"
            v-if="currentPage > 1"
            @click="prevPage">
                &lt;
        </v-button>
        <span class="current">{{ currentPage }} / {{ pages }}</span>
        <v-button
            class="next"
            v-if="currentPage < pages"
            @click="nextPage">
                &gt;
        </v-button>
    </div>
</template>

<script>
export default {
    props: {
        currentPage: { type: Number, required: true },
        pages: { type: Number, required: true },
    },
    methods: {
        prevPage() {
            this.$emit('pevious');
        },

        nextPage() {
            this.$emit('next');
        },
    },
}
</script>
