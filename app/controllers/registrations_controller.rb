class RegistrationsController < Devise::RegistrationsController
  respond_to :html, :json
end
# protected

# def after_sign_up_path_for(_resource)
#   :home_path
# end

# def after_inactive_sign_up_path_for(_resource)
#   :home_path
# end
