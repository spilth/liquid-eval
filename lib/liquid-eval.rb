require "liquid-eval/version"
require "liquid"

module LiquidEval

  class EvalBlock < ::Liquid::Block
    def initialize(name, language, tokens)
      super
      @code = @nodelist[0].to_s.gsub(/^$\n/, '')
      @language = language.strip

      case @language
      when "ruby"
        @result = interpret("ruby", "rb")
      when "python"
        @result = interpret("python", "py")
      else
        @result = "Language not currently supported by Liquid::EvalBlock."
      end
    end

    def render(context)
      %Q[<h6>Code:</h6><pre><code>#{@code}</code></pre><h6>Output:</h6><pre class="output"><code>#{@result}</code></pre>]
    end

    def interpret(interpreter, extension)
      filename = "/tmp/#{interpreter}-codeblock.#{extension}"
      File.open(filename, 'w') {|f| f.write("#{@code}")}
      @result = `#{interpreter} #{filename}`
    end

  end
end

::Liquid::Template.register_tag 'eval', LiquidEval::EvalBlock

