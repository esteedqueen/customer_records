
This script does the following:
  - retrieves customer records from an `input.txt` file,
  - calculates the distance between the GPS coordinates of each customer and the GPS coordinates of the event venue/destination,
  - then returns a list of only the customers that are within 100km of the event venue/destination in `output.txt` file

# Prerequisites
You can run the script locally or on a server that has Ruby installed:

[Ruby](https://www.ruby-lang.org/en/documentation/installation/), I'm running version 2.6.3p62 locally.

# Getting started

Clone the repo and `cd` to the working directory

```bash
git clone git@github.com:esteedqueen/customer_records.git

cd customer-records
```

# Running the script

## using default file records and destination coordinates
```bash
ruby bin/find_invitable_customers.rb
```

## using custom file records and destination coordinates
PS: The file must exist in the file path provided.

```bash
ruby bin/find_invitable_customers.rb "53.339428, -6.257664" "input.txt"
```

# Running the tests

```bash
rake test
```
