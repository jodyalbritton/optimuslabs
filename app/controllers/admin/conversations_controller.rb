class Admin::ConversationsController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer	
  add_breadcrumb "Admin", :admin_index_path
  add_breadcrumb "Conversations", :admin_conversations_path
  layout "layouts/admin"

end
