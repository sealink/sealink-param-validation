# Sealink Param Validation

[![Gem Version](https://badge.fury.io/rb/sealink-param-validation.svg)](http://badge.fury.io/rb/sealink-param-validation)
[![Build Status](https://github.com/sealink/sealink-param-validation/workflows/Build%20and%20Test/badge.svg?branch=master)](https://github.com/sealink/sealink-param-validation/actions)

This is our gem for validation our params with schemas.

## Development Environment

### Prerequisites

1. Ruby

### General Steps

1. bundle install

### Testing

1. bundle exec rspec

### Release

To publish a new version of this gem the following steps must be taken.

* Update the version in the following files
  ```
    CHANGELOG.md
    lib/sealink_param_validation/version.rb
  ````
* Create a tag using the format v0.1.0
* Follow build progress in GitHub actions
