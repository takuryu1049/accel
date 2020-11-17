class ManagementForm < ActiveHash::Base
  self.data = [
    { id: 0, name: "未選択" },
    { id: 1, name: 'オープン' }, { id: 2, name: '一棟管理' },{ id: 3, name: '戸別管理' },{ id: 4, name: 'サブリース一棟管理(代理含む)'},{ id: 5, name: '家賃集金管理のみ'},{ id: 6, name: '他社管理' },{ id: 7, name: '物件内混合' }
  ]
end