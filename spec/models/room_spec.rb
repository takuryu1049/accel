# == Schema Information
#
# Table name: rooms
#
#  id              :bigint           not null, primary key
#  floor           :integer          not null
#  key_place       :string(255)
#  mail_num        :string(255)
#  management_form :string(255)      default("O"), not null
#  room_num        :string(255)
#  room_status     :string(255)      default("V"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  property_id     :bigint
#
# Indexes
#
#  index_rooms_on_property_id  (property_id)
#
require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @worker = FactoryBot.create(:worker)
    @company = @worker.company
    @owner = FactoryBot.create(:owner, :owner_swicth_is_human)
    @property = FactoryBot.build(:property)
    @property.company_id = @company.id
    @property.worker_id = @worker.id
    @property.owner_id = @owner.id
    @property.save
    @room = Room.create(room_num: Faker::Number.between(from: 1, to: 999), management_form: ["0","M","S","N"].sample, floor: Faker::Number.between(from: 1, to: 99), room_status: ["V","M"].sample, property_id: @property.id)
    sleep 0.1
  end
  
  describe '物件部屋登録' do
    # 正常系
    context '新規登録が成功する時' do
      it 'room_num｜management_form｜floor｜room_status |が存在すれば登録できる' do
        expect(@room).to be_valid
      end
    end
    context '新規登録が失敗する時' do
      context 'room_numについて' do
        it "room_numが空では登録できないこと" do
          @room.room_num = nil
          @room.valid?
          expect(@room.errors.full_messages).to include("部屋番号を入力してください")
        end
      end
      context 'management_formについて' do
        it "management_formが空では登録できないこと" do
          @room.management_form = nil
          @room.valid?
          expect(@room.errors.full_messages).to include("管理形態を入力してください")
        end
        it "management_formが異常な値では登録できないこと" do
          @room.management_form = "Z"
          @room.valid?
          expect(@room.errors.full_messages).to include("管理形態が異常な値です")
        end
      end
      context 'floorについて' do
        it "floorが空では登録できないこと" do
          @room.floor = nil
          @room.valid?
          expect(@room.errors.full_messages).to include("階数を入力してください")
        end
        it "floorが0以上99以内でない値の場合には登録できないこと" do
          @room.floor =  100
          @room.valid?
          expect(@room.errors.full_messages).to include("階数は1~99の範囲内かつ、半角数字で入力をしてください")
        end
      end
      context 'room_statusについて' do
        it "room_statusが空では登録できないこと" do
          @room.room_status = nil
          @room.valid?
          expect(@room.errors.full_messages).to include("入居状況を入力してください")
        end
        it "room_statusが異常な値では登録できないこと" do
          @room.room_status = "Z"
          @room.valid?
          expect(@room.errors.full_messages).to include("入居状況が異常な値です、画面を再度更新してください。")
        end
      end
    end
  end
end