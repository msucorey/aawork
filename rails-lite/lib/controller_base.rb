require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require 'active_support/inflector'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req, @res = req, res
    @params = route_params.merge(req.params)
    @already_built_response = false
    @@protect_from_forgery ||= false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "double render error" if @already_built_response
    #  Issuing a redirect consists of two parts, setting the 'Location'
    #  field of the response header to the redirect url and setting the
    #  response status code to 302
    @already_built_response = true
    res.location = url
    res.status = 302
    @session.store_session(res)
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise "double render error" if @already_built_response

    res.write(content)
    res['Content-Type'] = content_type

    @already_built_response = true

    @session.store_session(res)
    nil
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    path = "views/#{ActiveSupport::Inflector.underscore(self.class.to_s)}/#{template_name}.html.erb"
    ftext = File.read(path)
    template = ERB.new(ftext).result(binding)
    render_content(template, 'text/html')
#     Let's write a #render(template_name) method that will:
# Use controller and template names to construct paths to template files.
# Use File.read to read the template file.
# Create a new ERB template from the contents.
# Evaluate the ERB template, using binding to capture the controller's
# instance variables.
# Pass the result to #render_content with a content_type of text/html.
# We'll assume that any developers who use our framework are aware of
# our template naming convention, which is as follows:
# "views/#{controller_name}/#{template_name}.html.erb". Use
# ActiveSupport's #underscore (require 'active_support/inflector')
# method to convert the controller's class name to snake case. We'll be
# lazy and not chop off the _controller bit at the end.
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(req)
#     Implement a method ControllerBase#session which constructs a
#     session from the request. Lazily assign this in to an ivar,
#     (@session; use ||=) that can be returned on subsequent calls to
#     #session.
# Make sure that the #redirect_to and #render_content methods call
# Session#store_session so that the session information is stored in the
# cookie after the response is built.
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
  end
end
