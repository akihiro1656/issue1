class HomeController < ApplicationController
  def index
  end

  def calculate_time
    time_input = params[:time_input]
    
    # 4桁の数字をhh:mmに変換
    if time_input.present? && time_input.length == 4 && time_input =~ /^[0-9]{4}$/
      hours = time_input[0..1]
      minutes = time_input[2..3]
      
      # ここで時間を分に変換して、丸め処理を行うことができます
      total_minutes = hours.to_i * 60 + minutes.to_i
      # 丸め処理の実装（仮）
      # この部分は別の処理として後で実装できます

      # 計算結果を時間形式に戻す
      @result = "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}"
    else
      @result = "無効な時間形式です。4桁の数字を入力してください。"
    end
    
    render :index
  end
end

