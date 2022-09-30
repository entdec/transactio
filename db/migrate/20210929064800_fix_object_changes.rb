class FixObjectChanges < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def up
    return unless ActiveRecord::Base.connection.data_source_exists? 'transaction_log_entries'

    while Transactio::TransactionLogEntry.where('jsonb_typeof(object_changes) = ?', 'array').exists? do
      Transactio::TransactionLogEntry.where('jsonb_typeof(object_changes) = ?', 'array').limit(50000).find_each do |entry|
        entry.object_changes = entry.object_changes.to_h
        entry.save!
      end
    end
  end

  def down
  end
end
