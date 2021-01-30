require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザー新規登録" do
    it "ニックネームが空だと登録できない" do
      user = User.new(nickname: "", email: "sss@sss", password: "sss333", password_confirmation: "sss333", family_name: "てすと", first_name: "太郎", family_name_kana: "テスト", first_name_kana: "タロウ", birthday: "1900-01-01")
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end
    it "メールアドレスが空だと登録できない" do
      user = User.new(nickname: "てすと太郎", email: "", password: "sss333", password_confirmation: "sss333", family_name: "てすと", first_name: "太郎", family_name_kana: "テスト", first_name_kana: "タロウ", birthday: "1900-01-01")
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it "メールアドレスが一意でないと登録できない" do
      user = User.new(nickname: "てすと太郎", email: "sss@sss", password: "sss333", password_confirmation: "sss333", family_name: "てすと", first_name: "太郎", family_name_kana: "テスト", first_name_kana: "タロウ", birthday: "1900-01-01")
      user.save
      another_user = User.new(nickname: "てすと次郎", email: "sss@sss", password: "aaa111", password_confirmation: "aaa111", family_name: "てすと", first_name: "次郎", family_name_kana: "テスト", first_name_kana: "ジロウ", birthday: "1900-01-01")
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it "メールアドレスに@を含まないと登録できない" do
      user = User.new(nickname: "てすと太郎", email: "ssssss", password: "sss333", password_confirmation: "sss333", family_name: "てすと", first_name: "太郎", family_name_kana: "テスト", first_name_kana: "タロウ", birthday: "1900-01-01")
      user.valid?
      expect(user.errors.full_messages).to include("Email is invalid")
    end
    it "パスワードが空だと登録できない" do
      user = User.new(nickname: "てすと太郎", email: "sss@sss", password: "", password_confirmation: "sss333", family_name: "てすと", first_name: "太郎", family_name_kana: "テスト", first_name_kana: "タロウ", birthday: "1900-01-01")
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    it "パスワードは6文字以上でないと登録できない" do
      user = User.new(nickname: "てすと太郎", email: "sss@sss", password: "sss33", password_confirmation: "sss33", family_name: "てすと", first_name: "太郎", family_name_kana: "テスト", first_name_kana: "タロウ", birthday: "1900-01-01")
      user.valid?
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it "パスワードは半角英数字混合でないと登録できない" do
      user = User.new(nickname: "てすと太郎", email: "sss@sss", password: "ssssss", password_confirmation: "ssssss", family_name: "てすと", first_name: "太郎", family_name_kana: "テスト", first_name_kana: "タロウ", birthday: "1900-01-01")
      user.valid?
      expect(user.errors.full_messages).to include("Password Include both letters and numbers")
    end
    it "パスワードは確認用含め2回入力しないと登録できない" do
      user = User.new(nickname: "てすと太郎", email: "sss@sss", password: "sss333", password_confirmation: "", family_name: "てすと", first_name: "太郎", family_name_kana: "テスト", first_name_kana: "タロウ", birthday: "1900-01-01")
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it "パスワードと確認用パスワードは一致しないと登録できない" do
      user = User.new(nickname: "てすと太郎", email: "sss@sss", password: "sss333", password_confirmation: "aaa111", family_name: "てすと", first_name: "太郎", family_name_kana: "テスト", first_name_kana: "タロウ", birthday: "1900-01-01")
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "ユーザー本名は名字と名前がないと登録できない" do
      user = User.new(nickname: "てすと太郎", email: "sss@sss", password: "sss333", password_confirmation: "sss333", family_name: "", first_name: "", family_name_kana: "テスト", first_name_kana: "タロウ", birthday: "1900-01-01")
      user.valid?
      expect(user.errors.full_messages).to include("Family name can't be blank", "First name can't be blank")
    end
    it "ユーザー本名は全角（漢字・ひらがな・カタカナ）でないと登録できない" do
      user = User.new(nickname: "てすと太郎", email: "sss@sss", password: "sss333", password_confirmation: "sss333", family_name: "sss", first_name: "sss", family_name_kana: "テスト", first_name_kana: "タロウ", birthday: "1900-01-01")
      user.valid?
      expect(user.errors.full_messages).to include("Family name must be zenkaku kanji-kana-hiragana", "First name must be zenkaku kanji-kana-hiragana")
    end
    it "ユーザー本名のフリガナは名字と名前がそれぞれないと登録できない" do
      user = User.new(nickname: "てすと太郎", email: "", password: "sss333", password_confirmation: "sss333", family_name: "てすと", first_name: "太郎", family_name_kana: "", first_name_kana: "", birthday: "1900-01-01")
      user.valid?
      expect(user.errors.full_messages).to include("Family name kana can't be blank", "First name kana can't be blank")
    end
    it "ユーザー本名のフリガナは全角カタカナでないと登録できない" do
      user = User.new(nickname: "てすと太郎", email: "", password: "sss333", password_confirmation: "sss333", family_name: "てすと", first_name: "太郎", family_name_kana: "sss", first_name_kana: "sss", birthday: "1900-01-01")
      user.valid?
      expect(user.errors.full_messages).to include("Family name kana must be zenkaku kana", "First name kana must be zenkaku kana")
    end
    it "生年月日が空だと登録できない" do
      user = User.new(nickname: "てすと太郎", email: "", password: "sss333", password_confirmation: "sss333", family_name: "てすと", first_name: "太郎", family_name_kana: "テスト", first_name_kana: "タロウ", birthday: "")
      user.valid?
      expect(user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end