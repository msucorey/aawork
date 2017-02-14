require 'addressable/uri'
require 'rest-client'

# def index_users
  # url = Addressable::URI.new(
  #   scheme: 'http',
  #   host: 'localhost',
  #   port: 3000,
  #   path: '/users/.html'
  # ).to_s
  def update_user(email)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/2.json'
  ).to_s

  puts RestClient.patch(
    url,
    { user: { email: email } }
  )
  end
begin
update_user("gizmo@gizmo.gizmo")
rescue RestClient::Exception
end
#   url = Addressable::URI.new(
#     scheme: 'http',
#     host: 'localhost',
#     port: 3000,
#     path: '/users',
#     # query_values: {
#     #   'some_category[a_key]' => 'another value',
#     #   'some_category[a_second_key]' => 'yet another value',
#     #   'some_category[inner_inner_hash][key]' => 'value',
#     #   'something_else' => 'aaahhhhh'
#     # }
#   ).to_s
#   puts RestClient.get(url)
# end
#
# index_users



# Require addressable/uri and rest-client so that we can construct our
 # requests. Let's build (and then call) a method that will return all
 # the users in the db.
#
# # bin/my_script.rb
# def index_users
#     url = Addressable::URI.new(
#       scheme: 'http',
#       host: 'localhost',
#       port: 3000,
#       path: '/users.html'
#     ).to_s
#
#     puts RestClient.get(url)
# end
#
# index_users
