class ApiResponder < ActionController::Responder
  def api_behavior
    raise MissingRenderer, format unless has_renderer?

    if get? || patch? || put? || post?
      display resource
    else
      head :no_content
    end
  end
end
