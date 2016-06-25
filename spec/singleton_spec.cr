require "./spec_helper"

class Example
end

class OtherExample
end

class StatefulExample
  getter value : Int32
  @value = 42

  def inc
    @value += 1
  end
end

Spec.before_each do
  Singleton.reset
end

describe Singleton do
  describe ".instance" do
    it "can be fetched" do
      example = Singleton.instance_of(Example)
      example.should be_a(Example)
      typeof(example).should eq(Example)
    end

    it "is the same when fetched again" do
      example = Singleton.instance_of(Example)
      again_example = Singleton.instance_of(Example)
      example.should be(again_example)
      typeof(again_example).should eq(Example)
    end

    it "is of correct type when other type" do
      other_example = Singleton.instance_of(OtherExample)
      other_example.should be_a(OtherExample)
      typeof(other_example).should eq(OtherExample)
    end
  end

  describe ".reset" do
    it "resets all instances correctly" do
      stateful_example = Singleton.instance_of(StatefulExample)
      stateful_example.inc
      stateful_example.value.should eq(43)

      Singleton.reset
      
      stateful_example = Singleton.instance_of(StatefulExample)
      stateful_example.value.should eq(42)
    end
  end
end
