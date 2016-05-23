class StatsController < ApplicationController
  before_action :authenticate

  def show
    #@stats = User.group(&:plain_text_pass).having('COUNT(plain_text_pass) > 1').count
    @stats = User.find_by_sql(
    "SELECT
      COUNT(*) AS count
      ,plain_text_pass AS plain_text_pass
     FROM users
     GROUP BY users.plain_text_pass
     HAVING COUNT(*) > 1"
     )
  end

end
