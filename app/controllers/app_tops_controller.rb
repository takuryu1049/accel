class AppTopsController < ApplicationController
  def index
    @day_of_properties = current_company.properties.where(created_at: Time.now.in_time_zone.all_day)
    @month_of_properties = current_company.properties.where(created_at: Time.now.in_time_zone.all_month)
    @workers = current_company.workers
  end
end
