# encoding: utf-8
# -*- ruby -*-

$:.unshift File.join(File.dirname(__FILE__), "lib")

require 'rubygems'
require 'bundler/setup'

require "rake"
require "rake/clean"

require "fileutils"

require 'configuration-blocks/version'
require 'hoe'

task :default => [:spec]

desc "install by setup.rb"
task :install do
  sh "sudo ruby setup.rb install"
end

### Gem

Hoe.plugin :bundler
Hoe.plugin :yard
Hoe.plugin :gemspec

Hoe.spec 'configuration-blocks' do
  developer               ConfigurationBlocks::DEVELOPER, ConfigurationBlocks::EMAIL

  self.version         =  ConfigurationBlocks::VERSION
  self.rubyforge_name  =  ConfigurationBlocks::NAME
  self.summary         =  ConfigurationBlocks::SUMMARY
  self.description     =  ConfigurationBlocks::DESCRIPTION
  self.url             =  ConfigurationBlocks::URL

  self.remote_rdoc_dir = ''
  self.rsync_args      << '--chmod=a+rX'
  self.readme_file     = 'README.md'
  self.history_file    = 'docs/HISTORY'

  extra_dev_deps      << ['rspec',            '>= 2.6.0']   <<
                         ['yard',             '>= 0.8.2']   <<
                         ['rdoc',             '>= 3.8.0']   <<
                         ['redcarpet',        '>= 2.1.0']   <<
                         ['bundler',          '>= 1.0.10']  <<
                         ['hoe-bundler',      '>= 1.1.0']   <<
                         ['hoe-gemspec',      '>= 1.0.0']

  unless extra_dev_deps.flatten.include?('hoe-yard')
    extra_dev_deps << ['hoe-yard', '>= 0.1.2']
  end
end

task 'Manifest.txt' do
  puts 'generating Manifest.txt from git'
  sh %{git ls-files | grep -v gitignore | grep -v Gemfile > Manifest.txt}
  sh %{git add Manifest.txt}
end

task 'ChangeLog' do
  sh %{git log > ChangeLog}
end

desc "Fix documentation's file permissions"
task :docperm do
  sh %{chmod -R a+rX doc}
end

### Sign & Publish

desc "Create signed tag in Git"
task :tag do
  sh %{git tag -s v#{ConfigurationBlocks::VERSION} -m 'version #{ConfigurationBlocks::VERSION}'}
end

desc "Create external GnuPG signature for Gem"
task :gemsign do
  sh %{gpg -u #{ConfigurationBlocks::EMAIL} \
           -ab pkg/#{ConfigurationBlocks::NAME}-#{ConfigurationBlocks::VERSION}.gem \
            -o pkg/#{ConfigurationBlocks::NAME}-#{ConfigurationBlocks::VERSION}.gem.sig}
end

