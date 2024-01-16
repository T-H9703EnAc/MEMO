<template>
  <div>
    <h1>方角を選択してください</h1>
    <CustomRadioButton v-model="selectedDirection" />
    <!-- 他のコンテンツやロジック -->
  </div>
</template>

<script setup>
import { ref } from 'vue';
import CustomRadioButton from './CustomRadioButton.vue';

const selectedDirection = ref('');
// 他のスクリプトやメソッド
</script>

<style>
/* スタイル */
</style>
