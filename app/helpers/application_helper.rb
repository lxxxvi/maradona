module ApplicationHelper
  def bs_invalid_class(model)
    "is-invalid" if model.errors.any?
  end
end
