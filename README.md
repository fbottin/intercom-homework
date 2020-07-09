# Intercom Homework
Program to find and select customers within a range from a specified geolocation.

## Requirements

* Ruby 2.4+
* Bundler

## Installation

```
bundle install
```

## Getting Started

To run the programa it's very simple, just need to:
```
ruby main.rb
````

This will run the program with all the default parameters:
  * `customers.txt` as input file;
  * `output.txt` as outout file;
  * `53.339428` the latitude of Intercom Dublin office; 
  * `-6.257664` the longitude of Intercom Dublin office;
  * `100.00` max range for search of customers;
  * `user_id` field used to sort the results;
  * `asc` used for sort order.

To check for other options:

```
ruby main.rb --help
```

To change any parameter:

```
-i, --input:
  change the input file with customers list.
    Default "customers.txt"
-o, --output:
  change the output file for the selected customers list.
    Default "output.txt"
--lat:
  change the latitude.
    Default "53.339428"
--long:
  change the longitude.
    Default "-6.257664"
-r, --range:
  change the range in km.
    Default "100.00" km
-f, --field:
  change the field used to sort the results.
    Default "user_id"
--order:
  change the sort order.
    Default "asc"
```

#### Example

```
ruby main.rb --range 50.0 --output customers_in_50_km.txt
```

## Running tests

To run all the test suite

```
  rspec
```

To run a specific test file:

```
  rspec spec/main.rb
```
