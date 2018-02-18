# UPC Lookup

A socket server using only the Elixir and Erlang Core libraries that allows you to look up the price and name for an item by the product's UPC.

## Running Locally

* Clone the repo
* If you don't have Elixir setup, there is Docker configuration in the repo
  * Use `docker-compose build` to build the project and then `docker-compose up` to run the server with the default port of `4040`
* Run `PORT=4040 mix run --no-halt` from the project root
* You should see a message saying the server is accepting connections

To test locally, open a `telnet` client connection to the server:

* `telnet localhost 4040`
* Send a UPC across the telnet connection and hit `<Enter>`
* You should see the price and name of the product returned

## Demo App

If you just want to try out the lookup without cloning the repo you can open a `telnet` connection to `li1018-153.members.linode.com` on port `4040`.

## Test UPCs

Here are some of the UPCs I used while testing:

* 078913280024
* 041143051603
* 815301008439
