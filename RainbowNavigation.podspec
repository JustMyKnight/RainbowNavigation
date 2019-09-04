Pod::Spec.new do |spec|
  spec.name         = "RainbowNavigation"
  spec.version      = "2.0.4"
  spec.summary      = "Custom navigation and transition"
  spec.description  = "Easy to use RainbowNavigation to create a view navigation with alpha color"

  spec.homepage      = "https://github.com/JustMyKnight/RainbowNavigation"
  spec.license       = "MIT"
  spec.author        = { "Pavel Fokin" => "p_fokin@hotmail.com" }
  spec.source        = { :git => "https://github.com/JustMyKnight/RainbowNavigation.git", :tag => spec.version.to_s }
  spec.source_files  = "RainbowNavigation"
  spec.swift_version = "5"
end
