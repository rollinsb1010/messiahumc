email = 'development@ramblinglabs.com'
if ::Refinery::User.where(email: email).count == 0
  user = ::Refinery::User.create(
    username: 'ramblinglabs',
    email: 'development@ramblinglabs.com',
    password: '123123'
  )
  user.add_role(:refinery)
  user.add_role(:superuser)
  user.plugins = ::Refinery::Plugins.registered.names
end
