module FfcrmExtraDueTimes
  class Engine < ::Rails::Engine
    config.to_prepare do
      Task.class_eval do

        def self.due_two_weeks
          where('due_at >= ? AND due_at < ?', (Time.zone.now + 2.weeks).beginning_of_week.utc, (Time.zone.now + 2.weeks).end_of_week.utc + 1.day).order('tasks.id DESC')
        end

        def self.due_one_month
          where('due_at >= ? AND due_at < ?', (Time.zone.now + 1.month).beginning_of_month.utc, (Time.zone.now + 1.month).end_of_month.utc + 1.day).order('tasks.id DESC')
        end

        def self.due_three_months
          where('due_at >= ? AND due_at < ?', (Time.zone.now + 3.months).beginning_of_month.utc, (Time.zone.now + 3.months).end_of_month.utc + 1.day).order('tasks.id DESC')
        end

        def due_two_weeks?
          self.due_at.between?((Time.zone.now + 2.weeks).beginning_of_week, (Time.zone.now + 2.weeks).end_of_week)
        end

        def due_one_month?
          self.due_at.between?((Time.zone.now + 1.month).beginning_of_month, (Time.zone.now + 1.month).end_of_month)
        end

        def due_three_months?
          self.due_at.between?((Time.zone.now + 3.months).beginning_of_month, (Time.zone.now + 3.months).end_of_month)
        end

        def computed_bucket
          return self.bucket if self.bucket != "specific_time"
          case
          when overdue?
            "overdue"
          when due_today?
            "due_today"
          when due_tomorrow?
            "due_tomorrow"
          when due_this_week? && !due_today? && !due_tomorrow?
            "due_this_week"
          when due_next_week?
            "due_next_week"
          when due_two_weeks?
            "due_two_weeks"
          when due_one_month?
            "due_one_month"
          when due_three_months?
            "due_three_months"
          else
            "due_later"
          end
        end

        def set_due_date
          self.due_at = case self.bucket
          when "overdue"
            self.due_at || Time.zone.now.midnight.yesterday
          when "due_today"
            Time.zone.now.midnight
          when "due_tomorrow"
            Time.zone.now.midnight.tomorrow
          when "due_this_week"
            Time.zone.now.end_of_week
          when "due_next_week"
            Time.zone.now.next_week.end_of_week
          when "due_two_weeks"
            (Time.zone.now + 2.weeks).end_of_week
          when "due_one_month"
            (Time.zone.now + 1.month).end_of_month
          when "due_three_months"
            (Time.zone.now + 3.months).end_of_month
          when "due_later"
            Time.zone.now.midnight + 100.years
          when "specific_time"
            self.calendar ? parse_calendar_date : nil
          else # due_later or due_asap
            nil
          end
        end

      end
    end
  end
end
