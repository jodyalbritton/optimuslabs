class Admin::ConversationsController < ApplicationController
  layout "layouts/admin"
  before_action :login_required
  before_action :role_required
end
