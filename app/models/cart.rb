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

  def accessory_quantity(accessory_id)
    @contents[accessory_id.to_s]
  end

  def subtotal(accessory_id)
    accessory_quantity(accessory_id) * Accessory.find(accessory_id).price
  end

  def total
    sub_totals = []
    @contents.each do |id, quantity|
      sub_totals.push(Accessory.find(id).price * quantity)
    end
    sub_totals.sum
  end

  def accessory_ids
    ids = []
    @contents.each do |id, quantity|
      ids.push(id.to_i)
    end
    ids
  end

  def persisted?
    true
  end
end
