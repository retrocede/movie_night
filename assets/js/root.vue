<style lang="scss" scoped>
    p {
        color: red;
        border: 2px solid blue;
    }

    .fade-enter-active, .fade-leave-active {
        transition: opacity .5s;
    }
    .fade-enter, .fade-leave-to {
        opacity: 0;
    }
</style>

<style>
    .v-root {
        font-family: 'Oswald';
        color: #2D2C2C;
    }
</style>

<template>
    <div class="v-root">
        <v-header />
        <div class="content">
            <div class="v-router">
                <transition name="fade">
                    <router-view></router-view>
                </transition>
            </div>
        </div>
    </div>
</template>

<script>
import headerComponent from './layout/header';

export default {
    components: {
        'v-header': headerComponent,
    },
}
</script>

