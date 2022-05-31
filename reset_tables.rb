$:.unshift File.join(File.dirname(__FILE__), "lib")
require "database_connection"

def reset_tables(db)
  db.run("DROP TABLE IF EXISTS client;")
  db.run("CREATE TABLE client (id SERIAL PRIMARY KEY, username TEXT NOT NULL, password TEXT NOT NULL, name TEXT NOT NULL, contact_number TEXT NOT NULL, email TEXT NOT NULL);")

  db.run("DROP TABLE IF EXISTS properties;")
  db.run("CREATE TABLE properties (id SERIAL PRIMARY KEY, property_name TEXT NOT NULL, description TEXT NOT NULL, price FLOAT NOT NULL, availability_start DATE NOT NULL, availability_end DATE NOT NULL);")
end

dev_db = DatabaseConnection.new("localhost", "web_application_dev")
reset_tables(dev_db)

test_db = DatabaseConnection.new("localhost", "web_application_test")
reset_tables(test_db)
