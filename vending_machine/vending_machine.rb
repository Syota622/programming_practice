class Suica

  # 1. 初期状態で500円のチャージがされている
  def initialize
    @deposit = 500
  end

  # 1. Suicaには100円以上の任意の金額をチャージできる
  def charge(money)
    # 1. 100円未満をチャージしようとした場合は例外を発生させる
    raise "100円以上の金額をチャージしてください" if money < 100
    @deposit += money
  end

  # ゲッターメソッド
  def getDeposit
    @deposit
  end

  # セッターメソッド
  def setDeposit=(deposit)
    @deposit = deposit if deposit < 0
  end

end

class VendingMachine

  # 2. 初期状態で、ペプシ(150円)を5本格納している。
  def initialize
    @bool_purchase = false
    @sales = 0
    @stock = {name: "ペプシ", price: 150, count: 5}
  end

  # 2. 自動販売機はジュースを１種類格納
  def store(name, count)
    if name == @stock[:name]
      @stock[:count] += count
    end
  end

  # 2. ジュースの在庫を取得する
  def stock
    @stock[:count]
  end

  # 2. 自動販売機はペプシが購入できるかどうかを取得できる。
  # 2. チャージ残高が足りない場合もしくは在庫がない場合、購入操作を行った場合は例外を発生させる
  def purchase?(suica)
    if suica.getDeposit < @stock[:price]
      raise "チャージ残高が足りません"
    elsif @stock[:count] == 0
      raise "在庫がありません"
    else
      @bool_purchase = true
    end
  end

  # 3. ジュースを購入する
  def juice_purchase(suica)
    # 3. ジュースを購入できる場合
    if @bool_purchase
      # 3. ジュースの在庫を減らす
      @stock[:count] -= 1
      # 3. Suicaのチャージ残高を減らす
      suica.setDeposit = suica.getDeposit - @stock[:price]
      # 3. 売り上げ金額を増やす
      @sales += @stock[:price]
    end
  end

  # ゲッターメソッド
  def bool_purchase
    @bool_purchase
  end

  # ゲッターメソッド
  def sales
    @sales
  end

end

# ジュースを3種類管理できるようにする。
class VendingMachine2 < VendingMachine

  # 4. ジュースを3種類管理できるようにする。
  def initialize
    super()
    @stock2 = {name: "モンスター", price: 230, count: 5}
    @stock3 = {name: "いろはす", price: 120, count: 5}
  end

  # 4. 自動販売機はジュースを3種類格納
  def store(name, count)
    if name == @stock[:name]
      @stock[:count] += count
    elsif name == @stock2[:name]
      @stock2[:count] += count
    elsif name == @stock3[:name]
      @stock3[:count] += count
    end
  end

  # 4. 自動販売機は購入可能なドリンクのリストを取得
  def stock_list
    @stock_list = [@stock, @stock2, @stock3]
  end

  # 4. ジュースを購入できるかどうかを判定する
  def purchase?(suica, juice_name)

    @selected_juice = [@stock, @stock2, @stock3].find { |juice| juice[:name] == juice_name }

    if suica.getDeposit < @selected_juice[:price]
      raise "チャージ残高が足りません"
    elsif @selected_juice[:count] == 0
      raise "在庫がありません"
    else
      @bool_purchase = true
    end

  end

  # 4. ジュースを購入する
  def juice_purchase(suica, juice_name)
    if @bool_purchase
      # 4. ジュースの在庫を減らす
      @selected_juice[:count] -= 1
      # 4. Suicaのチャージ残高を減らす
      suica.setDeposit = suica.getDeposit - @selected_juice[:price]
      # 4. 売り上げ金額を増やす
      @sales += @selected_juice[:price]
    end
  end

end

puts ''
p '---------------suicaインスタンスを作成---------------'
puts ''

# 1. Suicaインスタンスを作成
suica = Suica.new()

# 1. チャージする
suica.charge(120)

# 1. チャージ残高を確認する
p '1. チャージ残高：' + suica.getDeposit.to_s + '円'

puts ''
p '---------------VendingMachineインスタンスを作成---------------'
puts ''

# 2. VendingMachineインスタンスを作成
vendingmachine = VendingMachine.new()

# 2. 自動販売機はジュースを１種類格納
vendingmachine.store("ペプシ", 10)

# 2. 自動販売機の在庫を取得
p '2. 自動販売機の在庫：' + vendingmachine.stock.to_s + '個'

# 3. ジュースを購入できるかどうかを判定する
vendingmachine.purchase?(suica)
p '3. ペプシ購入可能です' if vendingmachine.bool_purchase

# 3. ジュースを購入する
vendingmachine.juice_purchase(suica)

# 3. 売り上げ金額を確認する
p '3. 売り上げ金額：' + vendingmachine.sales.to_s + '円'

puts ''
p '---------------VendingMachine2インスタンスを作成---------------'
puts ''

# 4. VendingMachine2インスタンスを作成
vendingmachine2 = VendingMachine2.new()

# 4. 自動販売機に在庫を補充する
vendingmachine2.store("ペプシ", 10)
vendingmachine2.store("モンスター", 5)
vendingmachine2.store("いろはす", 1)

# 4. 自動販売機は購入可能なドリンクのリストを取得
p '4. ドリンクリスト：' + vendingmachine2.stock_list.to_s

# 4. ジュースを購入できるかどうかを判定する
vendingmachine2.purchase?(suica, "ペプシ")
p '4. ペプシ購入可能です' if vendingmachine2.bool_purchase

# 4. ジュースを購入する
vendingmachine2.juice_purchase(suica, "ペプシ")

# 4. 売り上げ金額を確認する
p '4. 売り上げ金額：' + vendingmachine2.sales.to_s + '円'
puts ''

# 4. ジュースを購入できるかどうかを判定する
vendingmachine2.purchase?(suica, "いろはす")
p '4. いろはす購入可能です' if vendingmachine2.bool_purchase

# 4. ジュースを購入する
vendingmachine2.juice_purchase(suica, "いろはす")

# 4. 売り上げ金額を確認する
p '4. 売り上げ金額：' + vendingmachine2.sales.to_s + '円'
puts ''
