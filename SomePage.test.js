import { describe, it } from 'vitest';
import { mount } from '@vue/test-utils';
import SomePage from './SomePage.vue';

describe('SomePage', () => {
  it('updates selectedDirection when a radio button is selected', async () => {
    const wrapper = mount(SomePage);

    // '東' を選択するラジオボタンを特定し、選択する
    const eastRadioButton = wrapper.find('input[type="radio"][value="東"]');
    await eastRadioButton.setChecked();

    // selectedDirection が '東' に更新されたことを確認
    expect(wrapper.vm.selectedDirection).toBe('東');
  });
});
