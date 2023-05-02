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
  def initialize(name, price)
    @name = name
    @price = price
  end

  # ゲッターメソッド
  def name
    @name
  end

  # ゲッターメソッド
  def price
    @price
  end

end

# 自動販売機を作成する
class VendingMachine

  # 初期値
  def initialize(juices)
    @bool_purchase = false
    @count = 0
    @sales = 0
    @juices = juices
  end

  # ジュースを購入できるかどうか判断する
  def purchase(suica, juice_name)

    @selected_juice = @juices.find { |juice| juice.name == juice_name }

    if suica.deposit < @selected_juice.price
      raise "チャージ残高が足りません"
    elsif @count == 0
      raise "在庫がありません"
    else
      juice_purchase(suica)
    end

  end

  # ジュースを購入する
  def juice_purchase(suica)
    # ジュースの在庫を減らす
    @count -= 1
    # Suicaのチャージ残高を減らす
    suica.deposit -= @selected_juice.price
    # 売り上げ金額を増やす
    @sales += @selected_juice.price
  end

  # 自動販売機はジュースを格納
  def store(name, count)
    target_juice = @juices.find { |juice| juice.name == name }
    @count += count if target_juice
  end

  # ゲッターメソッド
  def sales
    @sales
  end

  # セッターメソッド
  def sales=(sales)
    @sales = sales if sales >= 0
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

puts "========== 1回目の操作 =========="
# suicaインスタンス作成
suica = Suica.new()
suica.charge(200)
puts "Suicaのチャージ残高: #{suica.deposit}"

# ジュースを管理するためのインスタンスを作成
pepsi = Juice.new("ペプシ", 150)
monster = Juice.new("モンスター", 230)
irohasu = Juice.new("いろはす", 120)

# 自動販売機のインスタンスを作成
vending_machine = VendingMachine.new([pepsi, monster, irohasu])

vending_machine.store("ペプシ", 5)

# ジュースが購入できるかどうかを判定&ジュースの購入する
puts "#{pepsi.name}を購入できます" if vending_machine.purchase(suica, "ペプシ")

#チャージ残高を確認する
puts "Suicaのチャージ残高: #{suica.deposit}"

# 自動販売機は現在の売上金額を取得
puts "現在の売上金額: #{vending_machine.sales}"

puts
puts "========== 2回目の操作 =========="

suica.charge(300)
puts "Suicaのチャージ残高: #{suica.deposit}"

vending_machine.store("いろはす", 5)

# ジュースが購入できるかどうかを判定&ジュースの購入する
puts "#{irohasu.name}を購入できます" if vending_machine.purchase(suica, "いろはす")

#チャージ残高を確認する
puts "Suicaのチャージ残高: #{suica.deposit}"

# 自動販売機は現在の売上金額を取得
puts "現在の売上金額: #{vending_machine.sales}"

puts
puts "========== 3回目の操作 =========="

suica.charge(300)
puts "Suicaのチャージ残高: #{suica.deposit}"

vending_machine.store("モンスター", 5)

# ジュースが購入できるかどうかを判定&ジュースの購入する
puts "#{monster.name}を購入できます" if vending_machine.purchase(suica, "モンスター")

#チャージ残高を確認する
puts "Suicaのチャージ残高: #{suica.deposit}"

# 自動販売機は現在の売上金額を取得
puts "現在の売上金額: #{vending_machine.sales}"
