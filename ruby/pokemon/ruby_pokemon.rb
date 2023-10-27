
class Pokemon

  private

  def initialize(name, type1, type2, hp)
    @name
    @type1
    @type2
    @hp
  end

  def attack
    raise "attack method is not defined"
  end

end

class Picachu < Pokemon
  attr_accessor :name, :type1, :type2, :hp

  def initialize(name, type1, type2, hp)
    @name = name
    @type1 = type1
    @type2 = type2
    @hp = hp
  end

  # 親クラスのメソッドをオーバーライド
  def attack
    puts "#{@name}のこうげき!"
    puts "#{@name}の10万ボルト!"
  end

end

# 子クラスから宣言
picachu = Picachu.new("ピカチュウ", "でんき", "", 10)
puts picachu.name
puts picachu.attack

# 親クラスから宣言（抽象クラスのためエラーになる）
pokemon = Pokemon.new("ポケモン", "ノーマル", "", 10)
puts pokemon.name
