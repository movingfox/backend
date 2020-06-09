class EnablePgExtensions < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'citext'
    enable_extension 'hstore'
    enable_extension 'pgcrypto'
  end
end

