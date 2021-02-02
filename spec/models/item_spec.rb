require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品がうまくいく時' do
      it 'すべての情報が登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品がうまくいかない時' do
      it '商品画像がないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名がないと出品できない' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end
      it '商品の説明がないと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーの情報がないと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      it '商品の状態の情報がないと出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 1')
      end
      it '配送料の負担についての情報がないと出品できない' do
        @item.shipping_cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping cost must be other than 1')
      end
      it '発送元の地域の情報がないと出品できない' do
        @item.shipping_area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping area must be other than 1')
      end
      it '発送までの日数の情報がないと出品できない' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping date must be other than 1')
      end
      it '販売価格についての情報がないと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '販売価格は¥300~¥9,999,999の間でないと出品できない（¥300未満の場合）' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be hankaku-number and between ¥300~¥9,999,999')
      end
      it '販売価格は¥300~¥9,999,999の間でないと出品できない（¥10,000,000以上の場合）' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be hankaku-number and between ¥300~¥9,999,999')
      end
      it '販売価格は半角数字のみでないと出品できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be hankaku-number and between ¥300~¥9,999,999')
      end
    end
  end
end
