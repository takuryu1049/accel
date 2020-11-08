class Equipment < ActiveHash::Base
  self.data = [
    { id: 0, name: '駐車場あり' },
    { id: 1, name: '敷地内駐車場' }, { id: 2, name: '駐輪場あり' }, { id: 3, name: 'バイク置場あり' },
    { id: 4, name: 'エレベーター' }, { id: 5, name: '宅配ボックス' }, { id: 6, name: '敷地内ゴミ置き場' },
    { id: 7, name: 'バルコニー付き' }, { id: 8, name: 'ルーフバルコニー付き' }, { id: 9, name: '専用庭' },
    { id: 10, name: 'バリアフリー' }, { id: 11, name: 'オートロック' }, { id: 12, name: '集合郵便受け' }
  ]
end