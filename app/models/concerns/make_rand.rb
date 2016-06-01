module MakeRand
  extend ActiveSupport::Concern

  protected

  def make_rand_integer(size=1)
   (0...size).map { rand(10) }.join
  end

  def make_rand_string(size=1)
    o = ('A'..'Z').to_a + (0..9).to_a
    (0...size).map { o[rand(o.length)] }.join
  end

  def make_rand_string_downcase(size=1)
    make_rand_string(size).downcase.gsub(/(l|1|q|9|o|0)/, 'h')
  end
end
