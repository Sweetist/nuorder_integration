require_relative './address'
require_relative './adjustment'
require_relative './line_item'
require_relative './order_total'
require_relative './payment'

module Wombat
  # https://support.wombat.co/hc/en-us/articles/202555780-Orders
  class Order
    include Virtus.model(strict: true)

    # Unique identifier for the order
    attribute :id, String
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
    # Array of the orders line items
    attribute :line_items, Array[LineItem]
    # Array ot the orders adjustments
    attribute :adjustments, Array[Adjustment]
    # Customers shipping address
    attribute :shipping_address, Address
    # Customers billing address
    attribute :billing_address, Address
    # Array of the order’s payments
    attribute :payments, Array[Payments]
  end
end