require 'rake/testtask'


Rake::TestTask.new do |t|
  t.name = 'test:unit'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end

Rake::TestTask.new do |t|
  t.name = 'test:integration'
  t.libs << 'test'
  t.pattern = 'test/**/*_integration.rb'
end
