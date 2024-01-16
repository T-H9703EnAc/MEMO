<template>
  <div>
    <CustomRadioButton v-model="selectedDirection" />
    <button @click="handleSubmit">送信</button>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import CustomRadioButton from './CustomRadioButton.vue';

const selectedDirection = ref('');
const handleSubmit = () => {
  // ラジオボタンの値に基づいた処理をここで行う
};
</script>
