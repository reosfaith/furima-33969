FactoryBot.define do
  factory :buy_item do
    token             { "tok_abcdefghijk00000000000000000" }
    user_id           {2}
    item_id           {3}
    post_code         { "111-1111" }
    prefecture_id     { 2 }
    city              { "てすと市" }
    house_number      { "てすとてすと" }
    building_name     { "てすとてすと" }
    phone_number      { "09012345678" }
  end
end
