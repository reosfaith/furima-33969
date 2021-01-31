FactoryBot.define do
  factory :user do
    nickname              { 'てすと太郎' }
    email                 { 'sss@sss' }
    password              { 'sss333' }
    password_confirmation { password }
    family_name           { 'てすと' }
    first_name            { '太郎' }
    family_name_kana      { 'テスト' }
    first_name_kana       { 'タロウ' }
    birthday              { '1933-04-05' }
  end
end
