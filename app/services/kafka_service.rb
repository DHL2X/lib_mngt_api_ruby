require 'json'
class KafkaService
  KAFKA_BROKER = "localhost:9092"

  def self.kafka_client
    @kafka ||= Kafka.new(KAFKA_BROKER)
  end

  def self.consumer_transaction(topic, group_id)
    kafka_client
    consumer = @kafka.consumer(group_id: group_id)
    consumer.subscribe("topic")

    consumer.each_message do |message|
      puts message.value
    end
  ensure
    consumer.stop
  end

  # def self.process_message(message, topic)
  #   event = JSON.parse(message.value)
  #   pp event
  #   Rails.logger.info "Received message: #{event.value}"
  # rescue JSON::ParserError => e
  #   log_error("JSON parsing failed", e, topic, message.offset)
  # rescue => e
  #   log_error("Failed", e, topic, message.offset)
  # end

  def self.producer_transaction(message, topic = "INDEX")
    kafka_client
    event = message.to_json
    Rails.logger.info "Received message: #{event}, #{topic}" # check value
    @kafka.deliver_message(event, topic: topic)
  end

  def self.log_error(message, exception, topic, offset)
    puts "#{message}, topic:#{topic} at offset:#{offset}"
    puts "Error message: #{exception.message}"
  end
end
