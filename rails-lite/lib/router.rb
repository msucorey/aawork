class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

#   A Router keeps track of multiple Routes. Each Route should store the following information:
# The URL pattern it is meant to match (/users, /users/new, /users/(\d+), /users/(\d+)/edit, etc.).
# The HTTP method (GET, POST, PUT, DELETE).
# The controller class the route maps to.
# The action name that should be invoked.

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern = pattern
    @http_method = http_method
    @controller_class = controller_class
    @action_name = action_name
  end

  # checks if pattern matches path and method matches request method
  def matches?(req)
    (@pattern =~ req.path) &&
      (@http_method == req.request_method.downcase.to_sym)
#     Also write a method, Route#matches?(req), which will test whether
#     a Route matches a request. Remember that a route is a match only
#     if the pattern matches the request path and if its http_method
#       is the same as the request method (you can use
#       req.request_method). Note that pattern will be a Regexp, so you
#       should use the match operator =~, not ==.
# NB: Rack::Request#request_method returns an uppercase string,
# http_method is set as a lowercase symbol. Adjust accordingly!
  end

  # use pattern to pull out route params (save for later?)
  # instantiate controller and call controller action
  def run(req, res)
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  # simply adds a new route to the list of routes
  def add_route(pattern, method, controller_class, action_name)
    @routes << Route.new(pattern, method, controller_class, action_name)
  end

  # evaluate the proc in the context of the instance
  # for syntactic sugar :)
  def draw(&proc)
  end

  # make each of these methods that
  # when called add route
  [:get, :post, :put, :delete].each do |http_method|
    add_route(req.pattern, http_method, controller_class, action_name)
  end

  # should return the route that matches this request
  def match(req)
    @routes.each do |route|
      return route if route.matches?(req)
    end
  end

  # either throw 404 or call run on a matched route
  def run(req, res)
  end
end
