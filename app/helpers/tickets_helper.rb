module TicketsHelper
  def rand_str
    (0...3).map { ('A'..'Z').to_a[rand(26)] }.join
  end
  
  def rand_hex
    SecureRandom.hex(1)
  end
end
