module DelayedCountable
  extend ActiveSupport::Concern

  class_methods do
    def counts(relation, column:)
      increment_method_name = "increment_count__#{relation}_#{column}".to_sym
      decrement_method_name = "decrement_count__#{relation}_#{column}".to_sym

      counter_key_method_name = "counter_key__#{relation}_#{column}".to_sym

      define_method increment_method_name do
        key = send counter_key_method_name
        Service::Redis.client.incr(key)
      end

      define_method decrement_method_name do
        key = send counter_key_method_name
        Service::Redis.client.decr(key)
      end

      define_method counter_key_method_name do
        parent = send relation.to_s.to_sym

        parent_classname = parent.class.name
        parent_id = parent.id

        "#{parent_classname}:#{parent_id}:#{column}"
      end

      private increment_method_name, decrement_method_name, counter_key_method_name

      after_create increment_method_name
      after_destroy decrement_method_name
    end
  end
end
