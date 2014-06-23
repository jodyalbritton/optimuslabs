class Admin::MessagesController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Messages", :admin_categories_path
  layout 'admin'
  # GET /messages
  # GET /messages.json
  def index
    @user = current_user
    
  if params[:sent]
    @inbox = @user.sent
  else
    @inbox = @user.inbox 
  end

   
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @user = current_user
    @inbox = @user.inbox
   
  end

  # GET /messages/new
  def new
    
      @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
     unless current_user == nil
      @user = current_user 
      @message = @user.messages.new(message_params)
    else
      @message = Message.new(message_params)
  end
   

    respond_to do |format|
      if @message.save
        format.html { redirect_to [:admin, @message], notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to [:admin, @message], notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:full_name, :email, :body, :subject, :phone, :source)
    end
end
