class HomeController < ApplicationController
	before_action :authenticate_user!, only: :token

	def index
	end

	def about
	end

	def token
	end
end
