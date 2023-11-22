# Game

[![Ruby Code Style](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/standardrb/standard)

I'm building a game that will help kids build numerical automaticity.

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

## Start the server

Run

```bash
$ bin/dev
```

## Troubleshooting

- If Tailwind is only partially working, it is likely because some Tailwind classes you are trying to apply have been purged. Run `rails assets:clobber` and make sure you are running `bin/dev` and not `rails s`.

## Troubleshooting

Deploy

```bash
fly deploy
```

## Next Steps

- TBD
