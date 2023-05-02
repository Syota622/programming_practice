# スイカを作成する
class Suica

  # 初期状態で500円のチャージがされている
  def initialize
    @deposit = 500
  end

  # Suicaには100円以上の任意の金額をチャージできる
  def charge(money)
    # 100円未満をチャージしようとした場合は例外を発生させる
    raise "100円以上の金額をチャージしてください" if money < 100
    @deposit += money
  end

  # ゲッターメソッド
  def deposit
    @deposit
  end

  # セッターメソッド
  def deposit=(deposit)
    @deposit = deposit if deposit >= 0
  end

end

# ジュースを作成する
class Juice

  # 初期値
  ## 例）pepsi = Juice.new("ペプシ", 150, 5)
  def initialize(name, price, count)
    @name = name
    @price = price
    @count = count
  end

  # ゲッターメソッド
  def name
    @name
  end

  # ゲッターメソッド
  def price
    @price
  end

  # ゲッターメソッド
  def count
    @count
  end

  # セッターメソッド
  def count=(count)
    @count = count if count >= 0
  end
end

# 自動販売機を作成する
class VendingMachine

  # 初期値
  ## 例）vending_machine = VendingMachine.new([pepsi, monster, irohasu])
  def initialize(juices)
    @bool_purchase = false
    @sales = 0
    @juices = juices
  end

  # ジュースを購入できるかどうか判断する
  ## 例）suica：Suica.new()
  ## 例）juice_name："ペプシ"
  ## 例）@juices = [pepsi, monster, irohasu]
  ## 例）pepsi = Juice.new("ペプシ", 150, 5)
  def purchase(suica, juice_name)

    # @selected_juice = Juice.new("ペプシ", 150, 5)
    @selected_juice = @juices.find { |juice| juice.name == juice_name }

    if suica.deposit < @selected_juice.price
      raise "チャージ残高が足りません"
    elsif @selected_juice.count == 0
      raise "在庫がありません"
    else
      juice_purchase(suica)
    end

  end

  # ジュースを購入する
  def juice_purchase(suica)
    # ジュースの在庫を減らす
    @selected_juice.count -= 1
    # Suicaのチャージ残高を減らす
    suica.deposit -= @selected_juice.price
    # 売り上げ金額を増やす
    @sales += @selected_juice.price
  end

  # 自動販売機はジュースを格納
  def store(name, count)
    target_juice = @juices.find { |juice| juice.name == name }
    target_juice.count += count if target_juice
  end

  # ゲッターメソッド
  def sales
    @sales
  end

  # セッターメソッド
  def sales=(sales)
    @sales = sales if sales >= 0
  end

end

puts "========== 1回目の操作 =========="
# suicaインスタンス作成
suica = Suica.new()
suica.charge(200)
puts "Suicaのチャージ残高: #{suica.deposit}"

# ジュースを管理するためのインスタンスを作成
pepsi = Juice.new("ペプシ", 150, 5)
monster = Juice.new("モンスター", 230, 5)
irohasu = Juice.new("いろはす", 120, 5)

# 自動販売機のインスタンスを作成
vending_machine = VendingMachine.new([pepsi, monster, irohasu])

# 自動販売機に在庫を補充する
puts "ペプシの在庫（ジュース格納前）: #{pepsi.count}"

vending_machine.store("ペプシ", 10)
puts "ペプシの在庫（ジュース格納後）: #{pepsi.count}"

# ジュースが購入できるかどうかを判定&ジュースの購入する
puts "#{pepsi.name}を購入できます" if vending_machine.purchase(suica, "ペプシ")
puts "ペプシの在庫（ジュース購入後）: #{pepsi.count}"

#チャージ残高を確認する
puts "Suicaのチャージ残高: #{suica.deposit}"

# 自動販売機は現在の売上金額を取得
puts "現在の売上金額: #{vending_machine.sales}"

puts
puts "========== 2回目の操作 =========="

suica.charge(300)
puts "Suicaのチャージ残高: #{suica.deposit}"

# 自動販売機に在庫を補充する
puts "ペプシの在庫（ジュース格納前）: #{irohasu.count}"

vending_machine.store("いろはす", 15)
puts "ペプシの在庫（ジュース格納後）: #{irohasu.count}"

# ジュースが購入できるかどうかを判定&ジュースの購入する
puts "#{irohasu.name}を購入できます" if vending_machine.purchase(suica, "いろはす")
puts "ペプシの在庫（ジュース購入後）: #{irohasu.count}"

#チャージ残高を確認する
puts "##### 1回目のチャージ残高：550円に加えて、チャージ金額：300円、購入金額：120円を計算した730円の結果が一致 #####"
puts "Suicaのチャージ残高: #{suica.deposit}"

# 自動販売機は現在の売上金額を取得
puts "##### 1回目に購入したペプシ：150円、2回目に購入したいろはす120円の合計270円が一致 #####"
puts "現在の売上金額: #{vending_machine.sales}"
