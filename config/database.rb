configure :test do
  set :database, {
    adapter: 'postgresql',
    encoding: 'utf8',
    database: 'onebitbot2_test',
    pool: 5,
    username: 'postgres',
    host: 'postgres'
  }
end
   
configure :development do
  set :database, {
    adapter: 'postgresql',
    encoding: 'utf8',
    database: 'onebitbot2_development',
    pool: 5,
    username: 'postgres',
    host: 'postgres'
  }
end