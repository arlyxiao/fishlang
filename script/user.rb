$dir = ARGV[0]


def save_users
  path = File.join($dir, 'users.yaml')
  rows = YAML.load_file(path)
  rows.each do |r|
    user = User.create!(
      {
        email: r['email'], 
        name: r['name'], 
        password: r['password'], 
        password_confirmation: r['password_confirmation'] 
      }
    )
    user.update_attribute :admin, true
  end
end

save_users