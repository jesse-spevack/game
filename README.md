# Game

[![Ruby Code Style](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/standardrb/standard)

I'm building a game that will help kids build numerical automaticity.

## Tapioca & Sorbet

We love Sorbet so we use it in this repo.

### Helpful commands and references

Regenerate active record rbi files; You'll need to do this as you create new rails models.

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

### Tailwind

If Tailwind is only partially working, it is likely because some Tailwind classes you are trying to apply have been purged. Run `rails assets:clobber` and make sure you are running `bin/dev` and not `rails s`.

### Fly.io

Right now we use 256mb of memory machines because 💰. Rails console requires more than this amoutn of memory. To scale the memory of the machine, run `fly scale memory 512`. Then to open rails console run: `fly ssh console --pty -C "/rails/bin/rails console"`

## Squashed Bugs and Errors

We added a `person_id` foreign key to the `Responses` table. Since `person_id` could not be null and there were existing `response` records in the DB, the deploy failed because the migration failed. The migration failed because of the existing `response` records not having an associated person. To fix, we opened production rails console and ran `Response.destroy_all`. In the future, either make the null constraint `false` or pre-emptively delete existing records that violate the constraint.

Deploy

```bash
fly deploy
```

## Next Steps

- P0 Add teams to player
  - add team_id to player ✅
  - add admin command to change all players to my team ✅
  - deploy and run command to change all players to my team ✅
  - drop user_id from player ✅
  - make team_id required on player and user ✅
- P1 Bias problem selection algo to less seen problems
- P1 Marketing
- P1 User Settings table
- P1 User timezone :/ - see `get_consecutive_days_played.rb`
- P1 Stripe Integration - https://stripe.com/payments/checkout
- P2 Force re-login after x days since last sign in
