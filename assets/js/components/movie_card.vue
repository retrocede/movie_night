<style lang="scss" scoped>
    @mixin md-icon-size($size: 24px) {
        font-size: $size;
        height: $size;
        width: $size;
    }

    .md-icon-16 {
        @include md-icon-size(16px);
    }

    .md-icon-18 {
        @include md-icon-size(18px);
    }

    .md-icon-24 {
        @include md-icon-size(24px);
    }

    .md-icon-36 {
        @include md-icon-size(36px);
    }

    .movie-card {
        padding: 0px;
        width: 154px;
        min-width: 154px;
        height: 231px;
        margin: 12px 10px;

        .overlay {
            display: flex;
            justify-content: space-between;
            flex-direction: column;
            align-items: center;
            opacity: 0;
            visibility: hidden;
            z-index: 10;
            height: 100%;
            width: 100%;
            transition: all ease-in-out 300ms;
            cursor: pointer;

            .controls {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-bottom: 50px;
                width: 100%;
            }

            .name {
                opacity: 0;
                color: white;
                margin: 5px 10px;
                text-align: center;
            }

            .add,
            .watch,
            .remove {
                opacity: 0;
                color: gray;

                &:hover {
                    color: white;
                }
            }

            .watch {
                margin-right: 12px;
            }

            .remove {
                margin-left: 12px;
            }
        }

        &:hover .overlay {
            background: rgb(0, 0, 0);
            opacity: 0.8;
            visibility: visible;
            transition: all ease-in-out 300ms;

            .add,
            .remove,
            .watch,
            .name {
                opacity: 1;
            }

        }
    }
</style>

<template>
    <div class="movie-card" :style='`background-image: url("${ this.poster }")`'>
        <div class="overlay">
            <div class="info">
                <div class="name">{{ name }} ({{ year }})</div>
            </div>
            <div class="controls" v-if='this.searchResult'>
                <div class="add" @click='added'>
                    <i class="material-icons md-icon-36">add_circle_outline</i>
                </div>
            </div>
            <div class="controls" v-else>
                <div class="watch" v-if="this.status !== 'watched'" @click="watched">
                    <i class="material-icons md-icon-36">play_circle_outline</i>
                </div>
                <div class="watch" v-else @click="unwatched">
                    <i class="material-icons md-icon-36">remove_circle_outline</i>
                </div>
                <div class="remove" @click="removed">
                    <i class="material-icons md-icon-36">block</i>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        poster: { type: String, required: true },
        name: { type: String, required: true },
        status: { type: String, required: true },
        release: { type: String, default: '' },
        searchResult: { type: Boolean, default: false },
    },
    computed: {
        year() {
            return this.release.split('-')[0];
        }
    },
    methods: {
        watched() {
            this.$emit('watch');
        },
        unwatched() {
            this.$emit('unwatch');
        },
        removed() {
            this.$emit('remove');
        },
        added() {
            this.$emit('add');
        }
    },
}
</script>
