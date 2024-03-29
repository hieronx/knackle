class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all

    #me = FbGraph::User.new('me', :access_token => session[:fb_access_token]).fetch
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])

    @active_assignment = Assignment.where(group_id: params[:id], finished: false)
    @active_user = @active_assignment.collect(&:user).first

    @messages = Message.where(group_id: params[:id]).order("updated_at DESC")[0..2]
    @message = Message.new

    @assignments = Assignment.where(group_id: @group.id).order("updated_at DESC")[0..3]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  def join
    group = Group.find(params[:id])
    if !current_user.groups.include? group
      current_user.groups << group
      current_user.save
    end

    redirect_to groups_url
  end

  def leave
    group = Group.find(params[:id])
    user_group = current_user.groups.find(group.id)
    
    if user_group
      current_user.groups.delete(user_group)
    end

    redirect_to groups_url
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
end
