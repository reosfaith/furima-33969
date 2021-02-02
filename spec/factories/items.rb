FactoryBot.define do
  factory :item do
    product_name     { 'てすとの商品' }
    price            { 300 }
    description      { 'てすとてすとてすと' }
    category_id      { 2 }
    condition_id     { 2 }
    shipping_cost_id { 2 }
    shipping_area_id { 2 }
    shipping_date_id { 2 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('spec/fixtures/test.png'), filename: 'test.png')
    end
  end
end
