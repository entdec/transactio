class FixObjectChanges < ActiveRecord::Migration[6.0]
  def up
    Transactio::TransactionLogEntry.where('jsonb_typeof(object_changes) = ?', 'array').find_each do |entry|
      entry.object_changes = entry.object_changes.to_h
      entry.save!
    end
  end

  def down
  end
end
