class WaterSupply < ActiveHash::Base
  self.data = [
    { id: 0, name: '未選択' },
    { id: 1, name: 'あり' }, { id: 2, name: 'なし' }
  ]
end
