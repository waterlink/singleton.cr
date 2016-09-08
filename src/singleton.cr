class Singleton
  abstract class Producer
    abstract def produce
  end

  class GenericProducer(T) < Producer
    getter produce : T
    def initialize(@produce) end
  end

  @@instances = {} of String => Producer

  def self.reset
    @@instances.clear
  end

  def self.instance_of(t : T.class) : T
    unless @@instances.has_key?(t.name)
      @@instances[t.name] = GenericProducer(T).new(t.new)
    end

    @@instances[t.name].produce.as T
  end
end
