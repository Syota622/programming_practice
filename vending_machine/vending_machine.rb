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
    @deposit = deposit if deposit < 0
  end

end

# ジュースを作成する
class Juice
  def initialize(name, count)
    @name = name
    @count = count
  end

  def name
    @name
  end

  def count
    @count
  end

  def count=(count)
    @count = count
  end

end

# 自動販売機を作成する
class VendingMachine

  def initialize(stock)
    @bool_purchase = false
    @sales = 0
    @juice = {name: "ペプシ", price: 150, count: 5}
    @juice2 = {name: "モンスター", price: 230, count: 5}
    @juice3 = {name: "いろはす", price: 120, count: 5}
    @stock = stock
  end

  # 自動販売機はジュースを3種類格納
  def store(name, count)
    if name == @juice[:name]
      @juice[:count] += count
    elsif name == @juice2[:name]
      @juice2[:count] += count
    elsif name == @juice3[:name]
      @juice3[:count] += count
    end
  end

  # 自動販売機は購入可能なドリンクのリストを取得
  def juice_list
    @juice_list = [@juice, @juice2, @juice3]
  end

  # ジュースを購入できるかどうかを判定する
  def purchase?(suica, juice_name)

    @selected_juice = [@juice, @juice2, @juice3].find { |juice| juice[:name] == juice_name }

    if suica.deposit < @selected_juice[:price]
      raise "チャージ残高が足りません"
    elsif @selected_juice[:count] == 0
      raise "在庫がありません"
    else
      @bool_purchase = true
    end

  end

  # ジュースを購入する
  def juice_purchase(suica, juice_name)
    if @bool_purchase
      # ジュースの在庫を減らす
      @selected_juice[:count] -= 1
      # Suicaのチャージ残高を減らす
      suica.deposit = suica.deposit - @selected_juice[:price]
      # 売り上げ金額を増やす
      @sales += @selected_juice[:price]
    end
  end

end

# suicaインスタンス作成
suica = Suica.new()
suica.charge(200)
puts "Suicaのチャージ残高: #{suica.deposit}"

# ジュースを管理するためのインスタンスを作成
pepsi = Juice.new("ペプシ", 5)
monster = Juice.new("モンスター", 5)
irohasu = Juice.new("いろはす", 5)

# 自動販売機のインスタンスを作成
vending_machine = VendingMachine.new([pepsi, monster, irohasu])

# ジュースを購入できるかどうかを判定する
vending_machine.purchase(suica, pepsi)

vending_machine.store(pepsi, 10)

vending_machine.purchase(suica, monster)

puts "購入可能なドリンク: #{vending_machine.available_drinks(suica)}"
puts "ペプシの在庫: #{vending_machine.juice("ペプシ")}"
puts "現在の売上金額: #{vending_machine.sales}"
puts "Suicaのチャージ残高: #{suica.balance}"


