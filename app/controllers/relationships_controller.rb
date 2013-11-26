class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:relationship][:child_id])
    current_user.parents!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).child
    current_user.unparent!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
