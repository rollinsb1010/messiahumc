email = 'development@ramblinglabs.com'
if ::Refinery::User.where(email: email).count == 0
  user = ::Refinery::User.create(
    username: 'ramblinglabs',
    email: 'development@ramblinglabs.com',
    password: '123123'
  )
end
