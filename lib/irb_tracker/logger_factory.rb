module LoggerFactory
  def self.create(service_name)
    if ENV['FLUENTD_LOGGING_ENABLED'] == 'true'
      require_relative '../fluentd'
      Fluentd.get_logger(
        service_name: service_name,
        host: ENV['FLUENTD_LOG_HOST'],
        port: ENV.fetch('FLUENTD_LOG_HOST_PORT', '24224'),
      )
    else
      require 'logger'
      log_folder = 'log'
      Dir.mkdir(log_folder) if not Dir.exists?(log_folder)
      Logger.new("./#{log_folder}/console.log")
    end
  end
end
