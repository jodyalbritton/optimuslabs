class Admin::ConversationsController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for ApplicationAuthorizer	
  layout "layouts/admin"

end
