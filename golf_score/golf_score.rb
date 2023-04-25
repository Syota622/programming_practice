# ゴルフのスコア
def score_name(hole, strokes)
  case strokes - hole
  when -4
    "コンドル" # 規定打数5で1打だった場合のみ該当
  when -3
    "アルバトロス"
  when -2
    "イーグル"
  when -1
    "バーディ"
  when 0
    "パー"
  when 1
    "ボギー"
  else
    "#{strokes - hole}ボギー"
  end
end

# ホールインワンの判定（コンドル以外で、1打で入れた場合）
def hole_in_one?(hole, strokes)
  hole != 5 && strokes == 1
end

# ARGF.readlines：引数を読み込む、chomp：改行を取り除く
# 「strokes - hole」引き算するため、line.to_iより、文字列から数値に変換
# % cat case_1.txt | ruby golf_score.rb -> ["4,4,5,3,5,4,4,3,4,4,5,4,4,3,4,4,3,5\n", "2,3,1,5,8,3,5,1,5,6,2,5,7,2,5,5,2,6\n"]
holes, scores = ARGF.readlines.map { |line| line.chomp.split(',').map { |line| line.to_i} }

# zip：要素ごとに配列を作成
result = holes.zip(scores).map do |hole, strokes|
  if hole_in_one?(hole, strokes)
    "ホールインワン"
  else
    score_name(hole, strokes)
  end
end

puts result.join(',')
