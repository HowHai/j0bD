class CreatePrimaryStats < ActiveRecord::Migration
  def change
    create_table :primary_stats do |t|
      t.references :employee, index: true
      t.integer :ruby
      t.integer  :css
      t.integer  :javascript
      t.integer  :coffeescript
      t.integer  :php
      t.integer  :java
      t.integer  :python
      t.integer  :c
      t.integer  :shell
      t.integer  :perl
      t.integer  :vimL
      t.integer  :scala
      t.integer  :go
      t.integer  :prolog
      t.integer  :clojure
      t.integer  :haskell
      t.integer  :lua
      t.timestamps
    end
  end
end
