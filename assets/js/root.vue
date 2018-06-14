<style lang="scss" scoped>
    p {
        color: red;
        border: 2px solid blue;
    }
</style>

<template>
    <div class="v-root">
        <v-header />
        <div class="content">
            <div class="v-router">
                <router-view></router-view>
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

