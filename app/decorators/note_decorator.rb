class NoteDecorator < SimpleDelegator
  def invalid_cls(key)
    "is-invalid" if err_key_exist?(key)
  end

  def invalid_feedback_cls(key)
    "invalid-feedback" if err_key_exist?(key)
  end

  def error_msg(key)
    errors.full_messages_for(key).first
  end

  def short_title
    title[0..10]
  end

  def short_body
    body[0..50]
  end

  private

  def err_key_exist?(key)
    errors.messages.key?(key)
  end
end
