class UsersController < ApplicationController
  def index
  	Zuleikha.add_to_queue(DobCreator, User.first.id)
  end
end
