#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
    gem.version               = File.read('VERSION').chomp
    gem.date                  = File.mtime('VERSION').strftime('%Y-%m-%d')

    gem.name                  = "pplcdid"
    gem.homepage              = "http://github.com/peoplecarbon/pplcdid"
    gem.license               = 'Apache'
    gem.summary               = "Decentralized IDentifier for Carbon Dioxide Removal."
    gem.description           = "This gem provides the basic methods for managing did:pplc."
    gem.metadata           = {
        "documentation_uri" => "https://peoplecarbon.github.io/pplcdid",
        "bug_tracker_uri"   => "https://github.com/peoplecarbon/pplcdid/issues",
        "homepage_uri"      => "http://github.com/peoplecarbon/pplcdid",
        "source_code_uri"   => "http://github.com/peoplecarbon/pplcdid/tree/main/ruby-gem",
    }

    gem.authors               = ['Jerry Zhang']

    gem.platform              = Gem::Platform::RUBY
    gem.files                 = %w(AUTHORS README.md LICENSE VERSION) + Dir.glob('lib/**/*.rb')
    gem.test_files            = Dir.glob('spec/**/*.rb') + Dir.glob('spec/**/*.json') + Dir.glob('spec/**/*.doc')

    gem.required_ruby_version = '>= 2.5.7'
    gem.requirements          = []
    gem.add_dependency 'dag',                   '~> 0.0.9'
    gem.add_dependency 'jwt',                   '~> 2.4.1'
    gem.add_dependency 'rbnacl',                '~> 7.1.1'
    gem.add_dependency 'ed25519',               '~> 1.3.0'
    gem.add_dependency 'httparty',              '~> 0.20.0'
    gem.add_dependency 'multibases',            '~> 0.3.2'
    gem.add_dependency 'multihashes',           '~> 0.2.0'
    gem.add_dependency 'multicodecs',           '~> 0.2.1'
    gem.add_dependency 'json-canonicalization', '~> 0.2.1'

    gem.add_development_dependency 'rspec',     '~> 3.10'

    gem.post_install_message = nil
end