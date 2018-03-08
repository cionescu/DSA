require 'colorize'
require 'irb'
require 'active_record'

class TestModel
  include ActiveRecord::Enum

  def number
    12
  end

  def blah?
    true
  end
end

class Describe
  attr_reader :context_name, :examples

  def initialize(context_name, &block)
    @context_name = context_name
    @describes = []
    @examples = []
    instance_eval &block
  end

  def describe(context_name, &block)
    describes << Describe.new(context_name, &block)
  end

  def it(context_name, &block)
    examples << Example.new(context_name, &block)
  end

  def test
    puts context_name
    describes.each do |describe_node|
      puts "  " + describe_node.context_name
      describe_node.examples.each do |example_node|
        color = example_node.test_result ? :green : :red
        puts "    " + example_node.context_name.colorize(color)
      end
    end
  end

  private
  attr_accessor :describes
end

def describe(context_name, &block)
  Describe.new(context_name, &block)
end

class Example
  attr_reader :context_name, :test_result

  def initialize(context_name, &block)
    @context_name = context_name
    instance_eval &block
  end

  def expect(result)
    @result = result
    self
  end

  def to(expectation)
    if expectation.is_a?(Proc)
      @test_result = expectation.call(result)
    else
      @test_result = expectation
    end
  end

  def eq(expectation)
    Proc.new { |n| n.eql?(expectation) }
  end

  def method_missing(method_name, *arguments, &block)
    class_method_name = "#{method_name.to_s.gsub('be_', '')}?"
    if method_name.to_s =~ /be_(.*)/ && result.respond_to?(class_method_name)
      result.send(class_method_name, *arguments, &block)
    else
      super
    end
  end

  private
  attr_reader :result
end

rspec = describe TestModel do
  describe '#number' do
    it 'returns 12' do
      expect(TestModel.new.number).to eq(12)
    end

    it "asserts blah?" do
      expect(TestModel.new).to be_blah
    end
  end
end

rspec.test
