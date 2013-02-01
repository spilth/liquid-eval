require "liquid-eval/version"

module LiquidEval
  class EvalBlock < Liquid::Block
    # language, interpreter, extension
    # ruby, ruby, rb

    def initialize(name, language, tokens)
      super
      @code = @nodelist[0].to_s.gsub(/^$\n/, '')
      @language = language.strip

      if @language == "ruby"
        File.open('/tmp/ruby-foo.rb', 'w') {|f| f.write("#{@code}")}
        @result = `ruby /tmp/ruby-foo.rb`
      else
        @result = "Language not currently supported by Liquid::EvalBlock."
      end
    end

    def render(context)
      %Q[<h6>Code:</h6><pre><code>#{@code}</code></pre><h6>Output:</h6><pre class="output"><code>#{@result}</code></pre>]
    end

  end
end

Liquid::Template.register_tag 'eval', LiquidEval::EvalBlock

