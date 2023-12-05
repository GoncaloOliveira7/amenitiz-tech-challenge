# Read me

Hello! Welcome to my cash register.

The Cash Register has 4 commands available to use.

They are displayed when you start the application and display you their keybind and description.

```bash
s) Show store items
a) Add items to cart
c) Show cart details
q) Quit store
```

## The following commands allow you to do the following

### Show store items
As the name sugestes this command allows the user to see all the available products in store.

```
==============================
| GR1 | Green Tea | 3.11€ |
| SR1 | Strawberries | 5.0€ |
| CF1 | Coffee | 11.23€ |
==============================
```

### Add items to cart
This Command allows users to add a product and it's quantity to the cart.

How to use the command: `d <product_code> <quantity>`

Here is an example: 
```
>>> a GR1 5
==============================
| Basket | Total Price Expected |
| GR1,GR1,GR1,GR1,GR1 | 9.33€ |
==============================
```

### Show cart details
Show Cart details allow's the user to see what item's he has on his cart and how much they will cost in total. 
The final price already has all discounts applied to them.

### Quit
Allows the user to quit the application

## Getting Started
To launch the application open the project in your terminal and run the command `bin/store.rb`
Note: Make sure you are using the ruby version 3.2.2

## Running Tests
To run the tests first you will need the use bundler to install the projects dependencies. To do this must have bundle and run the command `bundle install`.

After all dependencies are installed you can run the tests with the command ` rspec ./spec/store_spec.rb`

