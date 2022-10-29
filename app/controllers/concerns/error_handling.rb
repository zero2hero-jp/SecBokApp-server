module ErrorHandling
  extend ActiveSupport::Concern

  included do
    # impliment hook if you needed.
  end

  def goodbye(e)
    if e.kind_of? StandardError
# AT_SEE: https://github.com/zero2hero-jp/SecBokApp-server/issues/18
      render json: { 
        name: e.class.name,
        message: '何かが起こりました。'
      }, status: :internal_server_error

      logger.error e.class.name
      logger.error e.message
      e.backtrace.each { |line| logger.error line }

# AT_SEE: https://github.com/zero2hero-jp/SecBokApp-server/issues/19
    else
      raise e
    end
  end
end
