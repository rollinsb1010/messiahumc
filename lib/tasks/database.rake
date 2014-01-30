namespace :db do
  def sysputs(s)
    puts s
    system s
  end

  desc "Copy database from t2api to localhost"
  task :pull_prod do
    system "heroku pg:pull HEROKU_POSTGRESQL_SILVER_URL messiahumc_development -a messiah-umc"
  end

  desc "Complete reset of local database from production"
  task :refresh_from_production => [ :drop, :pull_prod, :seed ]
end
