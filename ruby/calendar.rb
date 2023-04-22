require 'date'
require 'optparse'

def calender_output(year, month)
  # 本日の日付を取得
  today = Date.today
  
  # 月初と月末の日付を取得
  first_day = Date.new(year, month, 1) #例）2023-04-01
  last_day = Date.new(year, month, -1) #例）2023-04-30

  puts "#{month}月 #{year}".rjust(12) #真ん中に寄せる
  puts "月 火 水 木 金 土 日"

  # wdayメソッドは曜日を0(日曜日)から6(土曜日)の整数で取得するが、月曜日始まりによる処理に変更
  # 例）「2023-04-01」は、(6+6)%7=5:土曜日なので、5個分のスペース(5*3)を表示
  print '   ' * ((first_day.wday + 6) % 7)

  # 各日付を表示（date：2023-03-01〜2023-03-31）
  (first_day..last_day).each do |date|
    # 日付を表示する
    if date == today
      print "\e[48;5;15m#{date.day.to_s.rjust(2)}\e[0m " # 本日日は背景色で強調
    else
      print date.day.to_s.rjust(2) + ' '
    end

    # 土曜日の場合は改行する（putsは、渡された引数を出力し、最後に改行文字（\n）を追加する）
    puts if date.sunday?
  end

  # 最後の週の改行
  puts
end

# コマンドラインのオプションを取り扱うためのライブラリ
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: calendar.rb [options]"

  opts.on('-m', '--month MONTH', 'Specify the month') do |month|
    options[:month] = month.to_i
  end
end.parse!

current_year = Date.today.year
month = options[:month] || Date.today.month

calender_output(current_year, month)


# ###############################################################################
# macでcalコマンドを実行した時の結果
# ruby % ruby calendar.rb -m 6
# 6月 2023
# 日 月 火 水 木 金 土
#              1  2  3 
#  4  5  6  7  8  9 10 
# 11 12 13 14 15 16 17 
# 18 19 20 21 22 23 24 
# 25 26 27 28 29 30