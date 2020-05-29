class RenameResultsToTestPassages < ActiveRecord::Migration[6.0]
  def up
    rename_table :results, :test_passages
  end

  def down
    rename_table :test_passages, :results
  end
end
