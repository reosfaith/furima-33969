require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'ニックネームが空だと登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'メールアドレスが空だと登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'メールアドレスが一意でないと登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'メールアドレスに@を含まないと登録できない' do
      @user.email = 'ssssss'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'パスワードが空だと登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは6文字以上でないと登録できない' do
      @user.password = 'sss33'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'パスワードは半角英数字混合でないと登録できない' do
      @user.password = 'ssssss'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
    end
    it 'パスワードは確認用含め2回入力しないと登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it 'パスワードと確認用パスワードは一致しないと登録できない' do
      @user.password_confirmation = 'aaa111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'ユーザー本名は名字と名前がないと登録できない' do
      @user.family_name = ''
      @user.first_name  = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank", "First name can't be blank")
    end
    it 'ユーザー本名は全角（漢字・ひらがな・カタカナ）でないと登録できない' do
      @user.family_name = 'sss'
      @user.first_name = 'sss'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name must be zenkaku kanji-kana-hiragana',
                                                    'First name must be zenkaku kanji-kana-hiragana')
    end
    it 'ユーザー本名のフリガナは名字と名前がそれぞれないと登録できない' do
      @user.family_name_kana = ''
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana can't be blank", "First name kana can't be blank")
    end
    it 'ユーザー本名のフリガナは全角カタカナでないと登録できない' do
      @user.family_name_kana = 'sss'
      @user.first_name_kana = 'sss'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name kana must be zenkaku kana',
                                                    'First name kana must be zenkaku kana')
    end
    it '生年月日が空だと登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
