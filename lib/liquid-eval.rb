require 'liquid-eval/version'
require 'liquid'
require 'cgi'

module LiquidEval
  
  def self.register_language(language, interpreter, extension)
    puts "Registering language #{language} with interpreter #{interpreter} and extension #{extension}." 
  end

  class EvalBlock < ::Liquid::Block
    attr_reader :code_html, :result

    def initialize(name, language, tokens)
      super
      @code = @nodelist[0].to_s.gsub(/^$\n/, '')
      @code_html = CGI.escapeHTML(@code)
      @language = language.strip

      case @language
      when 'ruby'
        @result = interpret('ruby', 'rb')
      when 'python'
        @result = interpret('python', 'py')
      when 'perl'
        @result = interpret('perl', 'pl')
      when 'php'
        @result = interpret('php', 'php')
      when 'bash'
        @result = interpret('bash', 'sh')
      else
        @result = 'Language not currently supported by Liquid::EvalBlock.'
      end
    end

    def render(context)
      if @result == ""
        %Q[<h6>Code:</h6><pre><code>#{@code_html}</code></pre>]
      else
        %Q[<h6>Code:</h6><pre><code>#{@code_html}</code></pre><h6>Output:</h6><pre class="output"><code>#{@result}</code></pre>]
      end
    end

    def interpret(interpreter, extension)
      filename = "/tmp/#{interpreter}-codeblock.#{extension}"
      File.open(filename, 'w') {|f| f.write(@code)}
      CGI.escapeHTML(`#{interpreter} #{filename} 2>&1`)
    end

  end
end

::Liquid::Template.register_tag 'eval', LiquidEval::EvalBlock

