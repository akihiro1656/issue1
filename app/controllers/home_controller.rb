class HomeController < ApplicationController
  def index
    @result = nil  # 初期化
  end

  def calculate_time
    time_input = params[:time_input]
    rounding_option = params[:rounding_option]
    rounding_unit = params[:rounding_unit].to_i

  valid_units = [5, 10, 15, 20, 30, 60]

    if time_input.present? && time_input =~ /^\d{2}:\d{2}$/
      hours, minutes = time_input.split(':').map(&:to_i)
      total_minutes = hours * 60 + minutes

    if valid_units.include?(rounding_unit) && rounding_unit > 0
        remainder = total_minutes % rounding_unit

        if rounding_option == 'up' && remainder > 0
          # 四則演算のみでの切り上げ
          total_minutes = total_minutes + (rounding_unit - remainder)
        elsif rounding_option == 'down'
          # 四則演算のみでの切り捨て
          total_minutes = total_minutes - remainder
        end
      end

      # 分を時間に戻す
      rounded_hours = total_minutes / 60
      rounded_minutes = total_minutes % 60

      # 結果を時間形式で表示
      @result = "#{rounded_hours.to_s.rjust(2, '0')}:#{rounded_minutes.to_s.rjust(2, '0')}"
    else
      @result = "無効な時間形式です。hh:mm 形式で入力してください。"
    end

  redirect_to root_path, flash: { result: @result }
  end
end
