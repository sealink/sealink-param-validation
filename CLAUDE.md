# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Ruby gem (`sealink-param-validation`) that provides Rails controller parameter validation using dry-schema. Controllers include `SealinkParamValidation::Concern` and declare schemas per action via `schema_for`. Invalid params return 422 with error messages.

## Commands

```bash
bundle install          # Install dependencies
bundle exec rspec       # Run all tests
bundle exec rspec spec/helper_spec.rb  # Run a single spec file
```

## Architecture

- **`lib/sealink_param_validation/concern.rb`** — ActiveSupport::Concern included in controllers. `schema_for(action, schema)` registers a dry-schema per action and adds a `before_action` that validates params. Two validation paths: `ensure_schema` (renders 422 JSON) and `ensure_schema!` (raises `InvalidInputError`).
- **`lib/sealink_param_validation/helper.rb`** — Formats dry-schema validation errors into strings. `generate_error_message` returns full error paths; `generate_humanized_error_message` returns humanized field names with `to_sentence`.
- **`lib/sealink_param_validation/error.rb`** — `InvalidInputError` exception class.

## Key Dependencies

- `rails` (ActiveSupport::Concern, ActionController)
- `dry-schema` (>= 1.0.0) for param validation schemas

## Testing

Tests use `rspec-rails` with a minimal Rails application defined in `spec/spec_helper.rb`. The validation spec creates a `DummyController` with routes to test the concern end-to-end.

## Release Process

1. Update version in `lib/sealink_param_validation/version.rb` and `CHANGELOG.md`
2. Create a git tag in format `v0.1.0`
3. Push — GitHub Actions handles the build/publish
