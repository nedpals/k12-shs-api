> ### **ATTENTION:** This project was no longer maintained. Please go to [https://github.com/sorxrob/k-to-12-shs-api](https://github.com/sorxrob/k-to-12-shs-api) for the the maintained fork by @sorxrob .

# DepEd K12 SHS API
A list of Senior High Schools from DepEd now in an API.
[Original data](http://www.deped.gov.ph/k-to-12/shs?page=431)

## Why did you do it?
DepEd's site sucks so I decided to make my own project that can search for schools based on their offerings.

## How did you do it?
I scraped the DepEd's website using Ruby, [Wombat](https://github.com/felipecsl/wombat) gem, deep_merge, and some free time.
For the server, I used [typicode/json-server](https://github.com/typicode/json-server) for light handling and fast public API setup.

## How to use it?
### Public API
I maintained a public API that can be used in web projects and it's very easy to get aboard. It updates whenever there are new changes to this repo:

[https://shs-k12-api.now.sh](https://shs-k12-api.now.sh)

Here's also a mirror:
http://139.59.105.62:5002/schools

For documentation regarding the use of the public API, click [here](PUBLIC-API-DOCS.md).

### Database
1. You can simply consume it directly by using this URL:
```
https://cdn.rawgit.com/nedpals/k12-shs-api/master/output.json
```

or...
2. Generate your own:
```bash
# Install first the dependencies.
$ gem install deep_merge wombat

# 1. Execute the script.
$ ruby aggregator/scraper.rb

# 2. Merge all data scraped using this script.
$ ruby aggregator/collector.rb
```
### Server
Simply run `npm install` or `yarn install` and start using it by simply executing the `npm run start` command.



# Disclaimer / Note
I would suggest to use it on a monthly basis as DepEd's servers may overload or else we can't able to grab data again :(

### (c) 2017 nedpals
