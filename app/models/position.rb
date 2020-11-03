class Position < ActiveHash::Base
  self.data = [
    { id: 0, name: '役職が選択されていません' },
    { id: 1, name: '店長' }, { id: 2, name: '営業' },
    { id: 3, name: '事務' }
  ]
end
