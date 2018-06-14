<style lang="scss" scoped>
.header {
    width: 100%;
    height: 50px;
    border-bottom: 1px solid gray;
}
.logo {
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 100%;
    width: 100%;
}

.logo-text {
    font-weight: 300;

    .bold {
        font-weight: 600;
    }
}
</style>


<template>
    <header class="header">
        <div class="logo">
            <router-link class="logo-text" :to="{ name: 'home' }">
                <span class="bold">Movie</span> Night
            </router-link>
        </div>
    </header>
</template>

<script>
export default {
    
}
</script>
