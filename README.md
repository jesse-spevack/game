# Game

## Tapioca & Sorbet

We love Sorbet so we use it in this repo.

### Helpful commands and references

Regenerate active record rbi files

```bash
$ bin/tapioca dsl
```

[Tapioca](https://github.com/Shopify/tapioca) - "The swiss army knife of RBI generation."
[Sorbet](https://sorbet.org/) - "Sorbet is a fast, powerful type checker designed for Ruby."

## Database setup

Regenerate the seed database. Warning, this will delete existing records.

```bash
$ rails db:seed
```

## Tests

Run

```bash
$ rails test
```
