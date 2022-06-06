$:.unshift File.join(File.dirname(__FILE__), "lib")
require "database_connection"

def reset_tables(db)

  db.run("DROP TABLE IF EXISTS properties;")
  db.run("CREATE TABLE properties (
    id SERIAL PRIMARY KEY,
    property_name TEXT NULL,
    description TEXT NULL,
    price FLOAT NULL, 
    availability_start DATE NULL, 
    availability_end DATE NULL
    );")

  db.run("DROP TABLE IF EXISTS users;")
  db.run("CREATE TABLE users (
    id SERIAL PRIMARY KEY, 
    username TEXT NOT NULL, 
    password TEXT NOT NULL, 
    contact TEXT NULL, 
    email TEXT NULL
    );")
end

dev_db = DatabaseConnection.new("localhost", "web_application_dev")
reset_tables(dev_db)

test_db = DatabaseConnection.new("localhost", "web_application_test")
reset_tables(test_db)
