require 'rails_helper'

RSpec.describe BuyItem, type: :model do
  before do
    @buy_item = FactoryBot.build(:buy_item)
  end

  describe "商品の購入" do

    context "商品が購入できる時" do

      it "すべての情報が登録できる" do
        expect(@buy_item).to be_valid
      end
    end

    context "商品の購入ができない時" do

      it "郵便番号がないと購入できない" do
        @buy_item.post_code = ''
        @buy_item.valid?
        expect(@buy_item.errors.full_messages).to include("Post code can't be blank")
      end

      it "都道府県がないと購入できない" do
        @buy_item.prefecture_id = ''
        @buy_item.valid?
        expect(@buy_item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it "市区町村がないと購入できない" do
        @buy_item.city = ''
        @buy_item.valid?
        expect(@buy_item.errors.full_messages).to include("City can't be blank")
      end

      it "番地がないと購入できない" do
        @buy_item.house_number = ''
        @buy_item.valid?
        expect(@buy_item.errors.full_messages).to include("House number can't be blank")
      end

      it "電話番号がないと購入できない" do
        @buy_item.phone_number = ''
        @buy_item.valid?
        expect(@buy_item.errors.full_messages).to include("Phone number can't be blank")
      end

      it "郵便番号にハイフンがないと購入できない" do
        @buy_item.post_code = '1111111'
        @buy_item.valid?
        expect(@buy_item.errors.full_messages).to include("Post code must be number includes hypen" )
      end

      it "prefecture_idが1(--)だと購入できない" do
        @buy_item.prefecture_id = 1
        @buy_item.valid?
        expect(@buy_item.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it "電話番号が11桁以内の数値でないと購入できない（12桁以上の場合）" do
        @buy_item.phone_number = '123456789101'
        @buy_item.valid?
        expect(@buy_item.errors.full_messages).to include("Phone number must be number within 11 characters")
      end

      it "電話番号が11桁以内の数値でないと購入できない（数値以外を含む場合）" do
        @buy_item.phone_number = '123-456-789'
        @buy_item.valid?
        expect(@buy_item.errors.full_messages).to include("Phone number must be number within 11 characters")
      end

      it "クレジットカードの情報がないと購入できない" do
        @buy_item.token = ''
        @buy_item.valid?
        expect(@buy_item.errors.full_messages).to include("Token can't be blank")
      end

      it "use_idがないと購入できない" do
        @buy_item.user_id = ''
        @buy_item.valid?
        expect(@buy_item.errors.full_messages).to include("User can't be blank")
      end

      it "item_idがないと購入できない" do
        @buy_item.item_id = ''
        @buy_item.valid?
        expect(@buy_item.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end