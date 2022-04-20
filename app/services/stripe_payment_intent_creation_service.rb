class StripePaymentIntentCreationService
  def call(event)
    # Set up the required params for Kafka connection.
    host = ENV['KAFKA_URL']               
    port = ENV['KAFKA_PORT']      
    ssl_ca_cert = File.read(Rails.root.join('aiven', 'ca.pem'))          
    ssl_client_cert_key = File.read(Rails.root.join('aiven', 'service.key'))     
    ssl_client_cert = File.read(Rails.root.join('aiven', 'service.cert'))    
    topic = ENV['KAFKA_TOPIC']                               

    # Connect Kafka
    kafka = Kafka.new(
      seed_brokers: ["#{host}:#{port}"],
      ssl_ca_cert: ssl_ca_cert,
      ssl_client_cert: ssl_client_cert,
      ssl_client_cert_key: ssl_client_cert_key,
    )

    # Add iso8601 to hash
    string_data = JSON.dump(event)
    hash = JSON.parse(string_data)
    iso8601 = Time.now.iso8601
    hash[:iso8601] = iso8601
    new_string_data = JSON.dump(hash)

    # Deliver a json event with UUID as a key.
    kafka.deliver_message(new_string_data, topic: topic, key: JSON.generate(SecureRandom.hex(10)))
  end
end
