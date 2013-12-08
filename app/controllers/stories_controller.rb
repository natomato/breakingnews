class StoriesController < ApplicationController
  def index
    @stories = Story.latest(5)
  end

  def static
  end
end
