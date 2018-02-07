# Lazada

A Ruby API for http://www.lazada.com.my

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lazada'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lazada

## Lazada::Client

The client is the base for all communication with the API.

```ruby
client = Lazada::Client.new(api_key, user_id)
```

## Lazada::Client methods
### Lazada::Client#get_products
Get all or a range of products.
```ruby
client.get_products(filter)
```

Possible filter values are all, live, inactive, deleted, image-missing, pending, rejected, sold-out.

### Lazada::Client#create_product
Create a new product.
```ruby
client.create_product({ 'SellerSku' => 'lz001A', ... })
```

### Lazada::Client#update_product
Update the attributes of one or more existing products.
```ruby
client.update_product({ 'SellerSku' => 'lz001A', 'Price' => 12  })
```

### Lazada::Client#remove_product
Removes one or more products
```ruby
client.remove_product(seller_sku)
```

### Lazada::Client#get_categories
Get the list of all product categories.
```ruby
client.get_categories
```

### Lazada::Client#get_category_attributes
Returns a list of attributes with options for a given category.
```ruby
cleint.get_category_attributes(primary_cateogory_id)
```

### Lazada::Client#get_orders
Get the customer details for a range of orders.
```ruby
client.get_orders({ status: status })
```
Possible status values are pending, canceled, ready_to_ship, delivered, returned, shipped and failed.

### Lazada::Client#get_order
Get the order items for a single order.
```ruby
client.get_order(order_id)
```

### Lazada::Client#get_order_items
Returns the items for one order.
```ruby
client.get_order_items(order_id)
```

### Lazada::Client#set_images
Set the Images for a Product, by associating one or more URLs with it.
```ruby
client.set_images({ 'ProductImage' => { 'SellerSku' => 'lz001A', 'images' => { ... } } })
```

### Lazada::Client#feed_status
Returns detailed information about a specified feed.
```ruby
client.feed_status(feed_id)
```

### Lazada::Client#feed_list
Returns all feeds created in the last 30 days.
```ruby
client.feed_list
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yoolk/lazada. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
