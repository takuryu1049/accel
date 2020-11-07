class Type < ActiveHash::Base
  self.data = [
    { id: 0, name: "未選択" },
    { id: 1, name: 'アパート' }, { id: 2, name: 'マンション' },{ id: 3, name: '貸家' }
  ]
end
