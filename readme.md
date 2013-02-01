# Liquid Eval Block

Allows you to embed a block of code in your page as well as the output generated by that code.

## Usage

- Install the gem or add it to your projects `Gemfile`.
- Use `require 'liquid-eval'` somewhere in your code
  - For Jekyll projects, add this to a file in your `_plugins` directory.

Within a post or page you can now do:

    {% eval ruby %}
    puts "Hello, world!"
    {% endeval %}

This will generate the following HTML in your page:

    <h6>Code:</h6>
    <pre><code>puts "Hello, world!"</code></pre>

    <h6>Output:</h6>
    <pre class="output"><code>Hello, world!</code></pre> 
