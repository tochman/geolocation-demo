class FakeIp
  def initialize(*args)
    @args = args
  end

  def call(env)
    "#{self.class}::Logic".constantize.new(*@args).call(env)
  end

  class Logic
    def initialize(app, ip)
      @app = app
      @ip = ip
    end

    def call(env)
      env['HTTP_X_FORWARDED_FOR'] = nil
      env['REMOTE_ADDR'] = env['action_dispatch.remote_ip'] = @ip
      @status, @headers, @response = @app.call(env)
    end
  end
end