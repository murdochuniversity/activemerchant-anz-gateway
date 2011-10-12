Dir[File.expand_path('lib/*.rb')].each { |f| require f }
Dir[File.expand_path('spec/support/*.rb')].each { |f| require f}