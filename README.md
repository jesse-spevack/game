# Game

[![Ruby Code Style](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/standardrb/standard)

I'm building a game that will help kids build numerical automaticity.

## Tapioca & Sorbet

We love Sorbet so we use it in this repo.

### Helpful commands and references

Regenerate active record rbi files; You'll need to do this as you create new rails models.

```bash
# https://github.com/Shopify/tapioca?tab=readme-ov-file#generating-rbi-files-for-rails-and-other-dsls
$ bin/tapioca dsl

# https://github.com/Shopify/tapioca?tab=readme-ov-file#pulling-rbi-annotations-from-remote-sources
$ bin/tapioca gems

# https://github.com/Shopify/tapioca?tab=readme-ov-file#pulling-rbi-annotations-from-remote-sources
$ bin/tapioca annotations
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

- P0 Code review and clean up
- P0 CDN
- P1 Change team name
- P1 Email campaigns
- P2 Admin should be able to see orders
- P2 Admin should be able to see players
- investigate https://loops.so/pricing

- no bad words for player names
- Timzone edit more obvious
- Turn sound off option
- Delete account
- Pagevies - Consider Data Retention Policies: Implement policies for how long you'll retain this data, and consider periodic cleanup routines.
- Pagination for admin/requests
- Better admin tooling
- User should be able to set the level of the player
- Indicate progress when a player levels
- Possible bug? When I hit a number on the screen's keypad, but then hit enter on my computer, it repeated the number before entering it. It still marked it correct, but my "5" showed "55" before advancing me.
-
