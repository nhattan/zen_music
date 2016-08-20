module Api::ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from Exception do |error|
      handle_exception error
    end
  end

  protected

  def handle_exception(error=nil)
    case error
    when Api::Exception
      render json: error.as_json, status: error.status.to_sym
    else
      if error.is_a?(ActiveRecord::RecordNotFound)
        status = 404
      else
        status = :unprocessable_entity
      end
      render json: { success: 'false', message: error.message }, status: status
    end
  end
end
