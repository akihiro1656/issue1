class HomeController < ApplicationController
  def index
    @result = nil  # 初期化
  end

  def calculate_time
    time_input = params[:time_input]
    rounding_option = params[:rounding_option]
    rounding_unit = params[:rounding_unit].to_i

    valid_units = [5, 10, 15, 20, 30, 60]

    # time_input が "hh:mm" の形式であるかチェック
    if time_input.present? && time_input =~ /^\d{2}:\d{2}$/
      # "hh:mm" を数値として分解
      time_value = (time_input[0].to_i * 10 + time_input[1].to_i) * 60 + (time_input[3].to_i * 10 + time_input[4].to_i)
      hours = time_value / 60
      minutes = time_value - (hours * 60)

      # 分を四則演算で処理
    if valid_units.include?(rounding_unit)
        quotient = minutes / rounding_unit  # 商を求める
        remainder = minutes - (quotient * rounding_unit)  # 余りを計算する
        
        # 丸めオプションに応じた処理
        case rounding_option
        when 'up'
          minutes += (rounding_unit - remainder) if remainder > 0
        when 'down'
          minutes -= remainder
        when 'none'
          # 何もしない
        end

        # 分が60を超えた場合の処理
        if minutes >= 60
          hours += 1
          minutes -= 60
        end
      end

      # 四則演算で hh:mm の形式に戻す
      hour_part = (hours < 10 ? "0" : "") + hours.to_s
      minute_part = (minutes < 10 ? "0" : "") + minutes.to_s
      @result = hour_part + ":" + minute_part
    else
      @result = "無効な時間形式です。hh:mm 形式で入力してください。"
    end

    redirect_to root_path, flash: { result: @result }
  end
end