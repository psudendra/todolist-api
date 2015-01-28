class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @user
  end

  # POST /users
  # POST /users.json
  # CURL EXAMPLE:
  # ~$ curl -H "Content-Type: application/json" -d '{"name":"Jud", "email":"Jud@test.com"}' http://localhost:3000/api/v1/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    head :no_content
  end

  private

    def set_user
      begin
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        render json: "User with id #{params[:id]} not found\n", status: 404
      end
    end

    def user_params
      # Require User would require us to make a request like so using curl (after -d):
      # -d '{"user": {name":"Jud", "email":"Jud@test.com"}}' http://localhost:3000/users
      # instead of just
      # -d '{"name":"Jud", "email":"Jud@test.com"}' http://localhost:3000/users
      #params.require(:user).permit(:name, :email)
      
      params.permit(:name, :email)
    end
end