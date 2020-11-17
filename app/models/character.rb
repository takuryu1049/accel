class Character < ActiveHash::Base
  self.data = [
    { id: 0, name: '未選択' },
    { id: 1, name: 'ムードメーカー' }, { id: 2, name: 'リーダー気質' },
    { id: 3, name: '笑顔を大事に' }
  ]
end
