require 'csv'
csv_text = File.read(Rails.root.join('lib', 'seeds', 'users.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
p  " loading # { users.csv } ... "
csv.each do |row|
  t = User.new
  t.id = row['id']
  t.name = row['name']
  t.email = row['email']
  t.password = row['password_plain']
  t.created_at = row['created_at']
  t.updated_at = row['updated_at']
  t.save
  # puts "#{t.name}, #{t.email} saved"
end
puts "There are now #{User.count} rows in the Users table"
