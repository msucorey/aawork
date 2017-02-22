require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    @cookie = req.cookies["_rails_lite_app"]
    if @cookie
      @cookie = JSON.parse(@cookie)
    else
      @cookie = {}
    end
    # Inside Session#initialize you should grab the cookie named
    # _rails_lite_app. If the session cookie has been set before, you
    # should use JSON to deserialize the value and store it in an ivar.
    # If no cookie has been set before, you should set the ivar to {}.
#     cookie = req.cookies["_rails_lite_app"]
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    attributes = { path: '/', value: @cookie.to_json }
    res.set_cookie('_rails_lite_app', attributes)
    #store_session(response) that will put the session into a cookie
#     and set it using Rack::Response#set_cookie.
# The first argument to #set_cookie is the name of the cookie which
# should be _rails_lite_app.
# The second argument is the cookie attributes. These are merely a hash
# of path: ..., value: ..., where path is the path where our cookie is
# available and value is a string. Since we want to pass a collection
# (our session store) in the cookie, we can serialize our instance
# variable using JSON. The path should be / (our root url) so the cookie
# will available at every path.
# NB: In order for this to work properly, the path and value keys in
# your hash must be symbols, not strings.
  end
end
