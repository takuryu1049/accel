class Ga  < ActiveHash::Base
  self.data = [
    { id: 0, name: '未選択' },
    { id: 1, name: '都市ガス' }, { id: 2, name: 'LP(プロパン)ガス' }, { id: 3, name: 'なし' }
  ]
end