def consolidate_cart(cart)
  # code here
  cart_hash = {}
  cart.each do |cart_item|
    cart_item.each do |name, data|
      if cart_hash[name]
        cart_hash[name][:count] += 1
      else
        cart_hash[name] = data
        cart_hash[name][:count] = 1
      end
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  # code here
  new_cart = {}
  cart.each do |grocery, info|
    coupons.each do |coupon|
      if grocery == coupon[:item] && info[:count] >= coupon[:num]
        cart[grocery][:count] = cart[grocery][:count] - coupon[:num]
        if new_cart[grocery + " W/COUPON"]
          new_cart[grocery + " W/COUPON"][:count] += 1
        else
          new_cart[grocery + " W/COUPON"] = {:price => coupon[:cost], :clearance => cart[grocery][:clearance], :count => 1}
        end
      end
    end
    new_cart[grocery] = info

  end
  new_cart
end

def apply_clearance(cart)
  # code here
  clearance_cart = {}
  cart.each do |item, info|
    clearance_cart[item] = {}
    info.each do |datum|
      if cart[item][:clearance]
        clearance_cart[item][:price] = (cart[item][:price] * 0.80).round(2)
      else
        clearance_cart[item][:price] = cart[item][:price]
      end
      clearance_cart[item][:clearance] = cart[item][:clearance]
      clearance_cart[item][:count] = cart[item][:count]

    end
  end
  clearance_cart
end


def checkout(items, coupons)
  cart = consolidate_cart(items)
  cart1 = apply_coupons(cart, coupons)
  cart2 = apply_clearance(cart1)
  
  total = 0
  
  cart2.each do |name, price_hash|
    total += price_hash[:price] * price_hash[:count]
  end
  
  total > 100 ? total * 0.9 : total
  
end

