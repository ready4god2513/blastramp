module Blastramp
  class Entity
    # Internal accessors
    attr_accessor :session

    class << self
      def has_properties(*properties)
        @properties = properties
        properties.each do |property|
          unless instance_methods.collect(&:to_s).include?(property.to_s)
            # Create property accessors that loads the full Entity from the API if necessary
            define_method "#{property}" do
              instance_variable_get("@#{property}")
            end
          end

          # Just use regular writers
          attr_writer property
        end
      end

      def properties
        @properties || []
      end
    end

    def initialize(values = {})
      initialize_defaults
      update_properties(values)
    end

    def initialize_defaults
      nil
    end

    def inspect
      props = self.class.properties.collect { |p| "#{p}=#{self.send(p).inspect}" }
      "#<#{self.class}:#{self.object_id}, #{props.join(', ')}>"
    end

    # Updates properties of Entity with the values from hash
    def update_properties(hash)
      hash.each do |key, value|
        self.send("#{key}=", value)
      end
    end
  
    # Returns OrderedHash with the data structure to send to the API
    def soap_data
    end
    
  end
end