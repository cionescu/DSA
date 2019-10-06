class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username, :name, :id
end
