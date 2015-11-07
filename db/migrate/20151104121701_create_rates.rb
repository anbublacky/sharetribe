class CreateRates < ActiveRecord::Migration

  def self.up
      create_table :rates do |t|
        t.string :rater_id
        t.string :rateable, :polymorphic => true
        t.float :stars, :null => false
        t.string :dimension
        t.timestamps
      end

      add_index :rates, :rater_id
      add_index :rates, [:rateable_id, :rateable_type]
    end

    def self.down
      drop_table :rates
    end

end