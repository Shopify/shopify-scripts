if Input.cart.discount_code
  Input.cart.discount_code.reject(
    message: "Maximum discount already applied! Discount codes can not be used during this promotion."
  )
end

Output.cart = Input.cart
