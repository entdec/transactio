# frozen_string_literal: true

namespace :transactio do
  desc 'Release a new version'
  task :release do
    version_file = './lib/transactio/version.rb'
    File.open(version_file, 'w') do |file|
      file.puts <<~EOVERSION
        # frozen_string_literal: true

        module Transactio
          VERSION = '#{Transactio::VERSION.split('.').map(&:to_i).tap { |parts| parts[2] += 1 }.join('.')}'
        end
      EOVERSION
    end
    module Transactio
      remove_const :VERSION
    end
    load version_file
    puts "Updated version to #{Transactio::VERSION}"

    package = JSON.parse(File.read('./package.json'))
    package['version'] = Transactio::VERSION
    File.open('./package.json', 'w') do |file|
      file.puts(JSON.pretty_generate(package))
    end

    `git commit package.json lib/transactio/version.rb -m "Version #{Transactio::VERSION}"`
    `git push`
    `git tag #{Transactio::VERSION}`
    `git push --tags`
  end
end
