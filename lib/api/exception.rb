module Api
  class Exception < StandardError
    attr_accessor :details
    attr_accessor :code

    attr_accessor :status
    attr_accessor :title
    attr_accessor :detail

    def initialize(code, details={})
      @details = details
      @code    = code

      @status = I18n.t "exceptions.#{code}.status"
      @title  = I18n.t "exceptions.#{code}.title", details
      @detail = I18n.t "exceptions.#{code}.detail", details

      @message = @detail
    end

    def as_json
      {
        title: title,
        detail: detail,
        code: code,
        status: status
      }
    end
  end
end
