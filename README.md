# DoMath.io

[![Ruby Code Style](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/standardrb/standard)

I'm building a game that will help kids build numerical automaticity.

## This game is built with

- Ruby
- Rails
- Sorbet
- Tapioca
- TailwindCSS
- Stimulus
- Postgresql
- ViewComponent
- and love.

## About the tech

### Tapioca & Sorbet

We love Sorbet so we use it in this repo.

#### Helpful commands and references

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

### Database setup

We use Postgresql.

Regenerate the seed database. Warning, this will delete existing records.

```bash
$ rails db:seed
```

### Tests

We use minitest and fixtures. Rails defaults are fine by us.

Run

```bash
$ rails test
```

### Start the server

Run

```bash
$ bin/dev
```

### Troubleshooting

#### Tailwind

If Tailwind is only partially working, it is likely because some Tailwind classes you are trying to apply have been purged. Run `rails assets:clobber` and make sure you are running `bin/dev` and not `rails s`.

#### Fly.io

Right now we use 256mb of memory machines because 💰. Rails console requires more than this amoutn of memory. To scale the memory of the machine, run `fly scale memory 512`. Then to open rails console run: `fly ssh console --pty -C "/rails/bin/rails console"`

### Squashed Bugs and Errors

We added a `person_id` foreign key to the `Responses` table. Since `person_id` could not be null and there were existing `response` records in the DB, the deploy failed because the migration failed. The migration failed because of the existing `response` records not having an associated person. To fix, we opened production rails console and ran `Response.destroy_all`. In the future, either make the null constraint `false` or pre-emptively delete existing records that violate the constraint.

## Deploy

```bash
fly deploy
```

## Next Steps

### 🔥 P0

- Turn sound off option
- No bad words for player names
- Delete account

### 🤨 P1

- Admin tooling improvements

### ✨ P2

- Email campaigns
  - investigate https://loops.so/pricing
- Timzone edit more obvious
- More in game feedback
  - score

### 🌤️ P3

- Player customizations based on points

# Changelog 🎉

## 2024-04-06

- Complete overhaul of admin ui and functionality.

## 2024-03-30

- Updated buttons to be more visually consistent.

## 2024-01-28

- Add progress bar

## 2024-01-27

- Add level up sound fx + confetti explosion
- Shorten levels by decreasing number of times a player must see a problem

## 2024-01-23

- When a player hit a number on the screen and then enter, the number repeated. - bug with the submission via enter
- Added an encouraging message when player levels up
- Delete requests after 14 days
- Admin view of players not belonging to the admin bug fix
- Fixed addition typo
- Fixed a bug where algorithm for finding next problem short circuits for player that just leveled up
