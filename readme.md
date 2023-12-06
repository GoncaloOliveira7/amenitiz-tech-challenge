# Read me

Hello! Welcome to my cash register.


## Getting Started
To launch the application open the project in your terminal and run the command `bin/store.rb`
Note: Make sure you are using the ruby version 3.2.2

## How to use it

The Cash Register has 4 commands available to use.

They are displayed when you start the application and display your keybind and description.

```bash
s) Show store items
a) Add items to cart
c) Show cart details
q) Quit store
```

## The following commands allow you to do the following

### Show store items
As the name suggests this command allows the user to see all the available products in store.

```
==============================
| GR1 | Green Tea | 3.11€ |
| SR1 | Strawberries | 5.0€ |
| CF1 | Coffee | 11.23€ |
==============================
```

### Add items to cart
This Command allows users to add a product and its quantity to the cart.

How to use the command: `d <product_code> <quantity>`

Here is an example: 
```
>>> a GR1 5
==============================
| Basket | Total Price |
| GR1,GR1,GR1,GR1,GR1 | 9.33€ |
==============================
```

### Show cart details
Show Cart details allows the user to see what items he has on his cart and how much they will cost in total. 
The final price already has all discounts applied to them.

### Quit
Allows the user to quit the application

## Running Tests
To run the tests first you will need the use bundler to install the projects dependencies. To do this must have bundle and run the command `bundle install`.

After all dependencies are installed you can run the tests with the command ` rspec ./spec/store_spec.rb`


## Technical details

### Command Class
Every Action you can take in the store is defined by a Class that inherits Command Object.
The Command object allows you to pick a keybind that will be used to trigger the event, a description, and a perform method to apply the logic to the system.

### Product Class
Every Product listed on the store is an Object that inherits from Product and allows your to pick a name, a product code and define the discount logic.


### Cart Class
It represents the users checkout cart and allows you to add products and list them.

### ConsoleInterface Class
The ConsoleInterface class is responsible for executing the CLI and you can change the number of commands and products just by adding them to the constructor.


### Store.rb
This script simply instantiates the ConsoleInterface and executes it.


