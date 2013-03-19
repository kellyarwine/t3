require "erb"

class T3
  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    T3::GameRunner.new.play_game
    @request = Rack::Request.new(env)
  end

  def response
    case @request.path
    when "/" then Rack::Response.new(render("index.html.erb"))
    when "/1" then Rack:Response.new
      Rack::Response.new do |response|
        response.redirect("/")
      end
    else Rack::Response.new("Not Found", 404)
    end
  end

  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end
end