class Meal < ApplicationRecord
  belongs_to :user

  def self.time_filter(meals,t1,t2)
    meals.reject { |meal| meal.date < t1 }.reject{|meal| meal.date >t2}
  end

  def self.admin_time_filter(meals,t1,t2)
    meals.reject { |meal| meal.date < t1 }.reject{|meal| meal.date >t2}
  end

  def self.search(meals,t1,t2)
    meals.reject { |meal| meal.date < t1}.reject { |meal| meal.date > t2}.reject { |meal| meal.date.hour > t2.hour}.reject { |meal| meal.date.hour < t1.hour}.reject { |meal| meal.date.min < t1.min}.reject { |meal| meal.date.min > t2.min}
  end


end
