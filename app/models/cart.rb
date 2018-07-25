class Cart
  attr_reader :contents

  def initialize(initial_content)
    @contents = initial_content || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_accessory(accessory_id)
    @contents[accessory_id.to_s] ||= 0
    @contents[accessory_id.to_s] += 1
  end

  def subtotal
    sub_totals = []
    @contents.each do |accessory_id, accessory_count|
      sub_totals.push(Accessory.find(accessory_id).price * accessory_count)
    end
    sub_totals
  end

  def total
    sub_totals = []
    @contents.each do |accessory_id, accessory_count|
      sub_totals.push(Accessory.find(accessory_id).price * accessory_count)
    end
    sub_totals.sum
  end
end
