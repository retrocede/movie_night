<style lang="scss" scoped>

</style>

<template>
    <button @click="clicked">
        <slot></slot>
    </button>
</template>

<script>
export default {
    methods: {
        clicked() {
            this.$emit('click');
        },
    },
}
</script>

