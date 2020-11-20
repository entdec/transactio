require_relative '../migration_generator'

module Transactio
  # Installs PaperTrail in a rails app.
  class InstallGenerator < MigrationGenerator
    source_root File.expand_path('templates', __dir__)

    desc 'Generates (but does not run) a migration to add the transactio tables.'

    def create_migration_file
      add_transactio_migration(
        'create_transactio'
      )
      # add_paper_trail_migration('add_object_changes_to_versions') if options.with_changes?
    end
  end
end
