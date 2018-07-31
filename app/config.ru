require "sinatra/base"

class App < Sinatra::Base
	get "/" do
		"Hello, I'm running on #{`hostname`}"
	end
end

run App
