$:.push File.expand_path("../lib", __FILE__)
require "liquid-eval/version"

Gem::Specification.new do |s|
  s.name = "liquid-eval"
  s.version = LiquidEval::VERSION
  s.authors = ["Brian Kelly"]
  s.email = ["polymonic@gmail.com"]
  s.homepage = "http://github.com/spilth/liquid-eval"
  s.summary = %q{Embedded Code and Output for Liquid}
  s.description = %q{Exexcutes code blocks and appends the generated output after the example code.}

  s.rubyforge_project = "liquid-eval"

  s.files = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency('jekyll', [">= 0.10.0"])
end

