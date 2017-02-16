# Extra due times plugin for Fat Free CRM tasks

## Due times

Following due times are available from plugin:

| Symbol              | Time         |
| ----                | -----------  |
| `:due_two_weeks`    | Two Weeks    |
| `:due_one_month`    | One Month    |
| `:due_three_months` | Three Months |

## Usage

1. Add plugin to Gemfile

    ```ruby
    gem 'ffcrm_extra_due_times'
    ```

2. __Append__ required due times to `task_bucket` in `config/settings.yml`:

    ```yaml
    task_bucket:
      - :due_two_weeks
      - :due_one_month
      - :due_three_months
    ```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Copyright © 2017 Ain Tohvri. Licenced under [GPL-3](LICENSE).
