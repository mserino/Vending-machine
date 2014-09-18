Vending Machine
===============

###Technologies
- Ruby
- RSpec

###How to use it?
`$ git clone https://github.com/mserino/Vending-machine`

`$ cd Vending-machine`

`$ irb`

`> require './lib/machine'`

`> machine = Machine.new`

`> machine.buy("Coke", "£1.5")`

if the amount is correct you'll receive this message

`Your product: Coke`

`> machine.buy("Coke", "£2")`

if the amount is more than the price you'll receive this message

`Your product: Coke - Change: 50p`

`> machine.buy("Coke", "£1")`

if the amount is not enough you'll be asked to add more money

`Please insert another 50p`

`> machine.add("50p", "Coke")`

`Your product: Coke`

You can check anytime the quantity of products and the amount of coin in the machine

`> machine.products`

`> machine.coins`

If you want to reload products and coins:

`> machine.reload`