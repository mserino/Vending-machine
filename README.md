[![Code Climate](https://codeclimate.com/github/mserino/Vending-machine/badges/gpa.svg)](https://codeclimate.com/github/mserino/Vending-machine)

Vending Machine
===============

###Technologies
- Ruby
- RSpec

###What is it?
Vending machine that allows to select products and receive the products. If too much money is inserted, returns the change, if the money is not enough, asks for more.

###How did I work?
I started creating the machine class with products and coins on initialization. Then I divided the code in three different classes, one for the machine (which has the main methods), one for the single product, and one for the stack of coins.
The .buy method inside the machine class is the most important, in which you can find all the logic for the products and the amount of money provided. The machine is initialized with some defined products (in this case Coke, Pringles and Mars), and a stack of coins of the UK denomination (5 for each small coin, 2 coin of £2 and £1). Every time an object is released from the machine, the relative amount of coin is added to the machine stack.

###How to use it?
Install ruby with RVM (if haven't done already):
`$ \curl -sSL https://get.rvm.io | bash`

`$ rvm install 2.1.1`


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