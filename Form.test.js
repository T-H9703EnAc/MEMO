import { describe, it } from 'vitest';
import { mount } from '@vue/test-utils';
import Form from './Form.vue';

describe('Form', () => {
  it('sets value in CustomTextbox within Form', async () => {
    const wrapper = mount(Form);

    // Form.vue 内の特定の CustomTextbox を見つける
    // 例: クラス名、ID、または他のセレクタを使用
    const textbox = wrapper.find('.custom-textbox-class input');
    await textbox.setValue('テストテキスト');

    // 値が正しく設定されたか確認
    expect(textbox.element.value).toBe('テストテキスト');
  });

  

  it('selects a radio button in CustomRadioButton within Form', async () => {
    const wrapper = mount(Form);

    // Form.vue 内の特定の CustomRadioButton を見つける
    // 例: value 属性を使用
    const radioButton = wrapper.find('input[type="radio"][value="選択肢1"]');
    await radioButton.setChecked();

    // ラジオボタンが正しく選択されたか確認
    expect(radioButton.element.checked).toBe(true);
  });

});
