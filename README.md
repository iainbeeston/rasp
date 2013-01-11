This is an idea I had for a general AOP library for ruby.

###Usage:

```ruby
require 'rasp/aspect'

class Cheese
  def slice
    # do something...
  end
end


class EmailAspect < Rasp::Aspect

  before :slice, on: Cheese do |obj|
    PurchaseMailer.new.contact_buyer(obj.field_a, obj.field_b).deliver
  end

end
```
