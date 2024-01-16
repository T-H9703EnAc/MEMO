<template>
  <CustomTextbox v-model="textValue" />
  <CustomRadioButton :options="radioOptions" v-model="radioValue" />
  <button @click="handleSubmit">送信</button>
</template>

<script setup>
import CustomTextbox from './CustomTextbox.vue';
import CustomRadioButton from './CustomRadioButton.vue';
import { ref } from 'vue';

const textValue = ref('');
const radioOptions = [{ value: 'option1' }, { value: 'option2' }];
const radioValue = ref('');

const handleSubmit = () => {
  // ここで textValue と radioValue に基づいて何かの処理を行う
  // 例: console.log(textValue.value, radioValue.value);
};
</script>
