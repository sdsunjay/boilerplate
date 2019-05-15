require 'csv'
# "id","product_name","description","style","brand","created_at","updated_at","url","product_type","shipping_price","note","admin_id"
csv_text = File.read(Rails.root.join('lib', 'seeds', 'products.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
p  " loading # { products.csv } ... "
csv.each do |row|
  t = Product.new
  t.id = row['id']
  t.name = row['product_name']
  t.description = row['description']
  t.style = row['style']
  t.brand = row['brand']
  t.created_at = row['created_at']
  t.updated_at = row['updated_at']
  t.url = row['url']
  if row['product_type'] == 'clothing'
    t.product_type = 0
  end
  t.user_id = row['user_id']
  t.save
  # puts "#{t.name} saved"
end
puts "There are now #{Product.count} rows in the Products table"
