class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :birthday, :password_confirmation,
            presence: true
  validates :password, :password_confirmation,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'Include both letters and numbers' }
  validates :family_name, :first_name, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: 'must be zenkaku kanji-kana-hiragana' }
  validates :family_name_kana, :first_name_kana, format: { with: /\A[ァ-ンー－]+\z/, message: 'must be zenkaku kana' }
end
