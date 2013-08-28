class ApiResponder < ActionController::Responder
  def api_behavior(error)
    raise error unless resourceful?

    if get? || patch? || put? || post?
      display resource
    else
      head :no_content
    end
  end
end
