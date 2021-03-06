module Wombat
  # https://support.wombat.co/hc/en-us/articles/202555780-Orders
  class Order

    class Address
      include Virtus.value_object(strict: true)

      attribute :firstname, String
      attribute :lastname, String, default: ''
      attribute :address1, String
      attribute :address2, String, default: ''
      attribute :zipcode, String
      attribute :city, String
      attribute :state, String, default: ''
      attribute :country, String, default: ''
      attribute :phone, String, default: ''
    end

    class Adjustment
      include Virtus.value_object(strict: true)

      attribute :name, String
      attribute :value, Integer
    end

    class LineItem
      include Virtus.value_object(strict: true)

      # Unique identifier of product
      attribute :product_id, String, strict: false
      # Product’s name
      attribute :name, String
      # Quantity ordered
      attribute :quantity, Integer
      # Price per item
      attribute :price, Numeric
    end


    # https://support.wombat.co/hc/en-us/articles/202555780-Orders#ordertotalobjectattributes
    class OrderTotal
      include Virtus.value_object(strict: true)

      # Total of price * quantity for all line items
      attribute :item, Numeric
      # Total of all adjustment values
      attribute :adjustment, Numeric, default: ->(this, _) { this.tax + this.shipping }
      # Total of tax adjustment values
      attribute :tax, Numeric
      # Total of shipping adjustment values
      attribute :shipping, Numeric
      # Total of all payments for this order
      attribute :payment, Numeric, default: ->(this, _) { this.item + this.adjustment }
      # Overall total of order
      attribute :order, Numeric, default: ->(this, _) { this.payment }
    end

    class Payment
      include Virtus.value_object(strict: true)

      attribute :number, Integer
      attribute :status, String
      attribute :amount, Numeric
      attribute :payment_method, String
    end

    class Retailer
      include Virtus.value_object(strict: true)

      attribute :retailer_name, String
      attribute :retailer_code, String
      attribute :buyer_name, String
    end

    include Virtus.value_object(strict: true)

    # Unique identifier for the order
    attribute :id, String
    # Nuorder internal id of order
    attribute :nuorder_id, String
    # Current order status
    attribute :status, String
    # Location where order was placed
    attribute :channel, String
    # Customers email address
    attribute :email, String
    # Currency ISO code
    attribute :currency, String
    # Date & time order was placed (ISO format)
    attribute :placed_on, String
    # Order value totals
    attribute :totals, OrderTotal
    # Nuorder specific, missing in official wombat docs
    attribute :rep_name, String
    # Nuorder specific, missing in official wombat docs
    attribute :rep_code, String
    # Nuorder specific, missing in official wombat docs
    attribute :retailer, Retailer
    # Array of the orders line items
    attribute :line_items, Array[LineItem]
    # Array ot the orders adjustments
    attribute :adjustments, Array[Adjustment]
    # Customers shipping address
    attribute :shipping_address, Address
    # Customers billing address
    attribute :billing_address, Address
    # Array of the order’s payments
    attribute :payments, Array[Payment]
  end
end
