<template>
  <input
    type="text"
    :value="value"
    @input="$emit('update:value', $event.target.value)"
  >
</template>

<script setup>
import { defineProps } from 'vue';

const props = defineProps({
  value: String
});
</script>
