class Qualification < ActiveHash::Base
  self.data = [
    { id: 0, name: '資格をお持ちであれば選択して下さい' },
    { id: 1, name: '宅地建物取引士' }, { id: 2, name: 'FP' }
  ]
end