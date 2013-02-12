require 'spec_helper'

describe LiquidEval::EvalBlock do
  include Liquid

  it "captures program output" do
    template = Liquid::Template.parse('{% eval ruby %}puts "Hello, Ruby!"{% endeval %}')
    template.root.nodelist[0].result.should eq "Hello, Ruby!\n"
  end

  it "captures program errors" do
    template = Liquid::Template.parse('{% eval ruby %}puts foo.to_s{% endeval %}')
    template.root.nodelist[0].result.should include "NameError"
  end

  it "escapes HTML characters in errors" do
    template = Liquid::Template.parse('{% eval python %}foo{% endeval %}')
    template.root.nodelist[0].result.should_not include "<module>"
  end

  it "doesn't produce an output code block when there's no output" do
    template = Liquid::Template.parse('{% eval ruby %}class Foo;end{% endeval %}')
    template.root.nodelist[0].code_html.should_not include '<pre class="output">'
  end

end


