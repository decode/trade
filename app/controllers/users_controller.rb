class UsersController < ApplicationController
  #before_filter :require_no_user, :only => [:new, :create]
  #before_filter :require_user, :only => [:show, :edit, :update]

  access_control do
    allow :admin, :manager
    allow :user, :guest, :except => [:index, :destroy]
    actions :new, :create do
      allow all
    end
  end

  access_control :secret_access?, :filter => false do
    allow :admin, :manager
  end
  
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @users }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @user }
    end
  end
  
  def create
    @user = User.new(params[:user])
    @user.has_role! 'guest'
    
    #if @user.save
    #  flash[:notice] = "Account registered!"
    #  redirect_back_or_default account_url
    #else
    #  render :action => :new
    #end
    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    if secret_access?
      @user = User.find(params[:id])
    else
      @user = @current_user
    end
  end

  def edit
    if secret_access?
      @user = User.find(params[:id])
    else
      @user = @current_user
    end
  end
  
  def update
    if secret_access?
      @user = User.find(params[:id])
    else
      @user = @current_user # makes our views "cleaner" and more consistent
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
