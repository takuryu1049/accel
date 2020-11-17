class Electrical < ActiveHash::Base
  self.data = [
    { id: 0, name: '未選択' },
    { id: 1, name: 'オール電化' }, { id: 2, name: 'あり' }, { id: 3, name: 'なし' }
  ]
end