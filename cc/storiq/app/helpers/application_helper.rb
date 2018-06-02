module ApplicationHelper
  def flash_class(flash_name)
    class_name = case flash_name.to_sym
      when :error, :danger, :alert
        "danger"
      when :warn, :warning
        "warn"
      when :success, :ok
        "success"
      else
        "info"
      end
    "alert-#{class_name}"
  end
end
