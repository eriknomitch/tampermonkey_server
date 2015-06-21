class LandingsController < ApplicationController
  def index
    render text: "Ubermonkey Server v. #{UbermonkeyServer::Application::VERSION}"
  end
end
