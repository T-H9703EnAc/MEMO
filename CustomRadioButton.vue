<template>
  <div>
    <input
      type="radio"
      :value="option.value"
      v-for="option in options"
      :key="option.value"
      :checked="option.value === value"
      @change="$emit('update:value', option.value)"
    >
  </div>
</template>

<script setup>
import { defineProps } from 'vue';

const props = defineProps({
  value: String,
  options: Array
});
</script>
