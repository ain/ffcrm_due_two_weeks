$:.push File.expand_path("../lib", __FILE__)

require "ffcrm_extra_due_times/version"

Gem::Specification.new do |s|
  s.name        = "ffcrm_extra_due_times"
  s.version     = FfcrmExtraDueTimes::VERSION
  s.authors     = ["Ain Tohvri"]
  s.email       = ["ain@flashbit.net"]
  s.homepage    = "https://github.com/ain/ffcrm_extra_due_times"
  s.summary     = "Fat Free CRM due times plugin"
  s.description = "Extra due time options plugin for Fat Free CRM tasks"
  s.license     = "GPL-3.0"

  s.files = `git ls-files`.split("\n")
  s.test_files = Dir["test/**/*"]

  s.add_dependency "fat_free_crm"

  s.add_development_dependency "mysql2"
end
