class FixObjectChanges < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def up
    Transactio::TransactionLogEntry.where('jsonb_typeof(object_changes) = ?', 'array').find_each do |entry|
      Transactio::TransactionLogEntry.transaction(requires_new: true) do
        entry.object_changes = entry.object_changes.to_h
        entry.save!
      end
    end
  end

  def down
  end
end
