class StoriesController < ApplicationController
  def index
    Story.update
    @stories = Story.latest
  end
end
