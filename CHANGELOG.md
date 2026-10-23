# Changelog

## 1.9.0

Mailjet has [deprecated some Email API endpoints](https://dev.mailjet.com/openapi/openapi-mailjet/deprecated-endpoints) and plans to shut them down. This release adds the one replacement the gem was missing and warns on the classes that wrap deprecated endpoints. Those classes will be removed in 2.0.0. See [Deprecated resources](README.md#deprecated-resources) in the README for the code changes.

### Added

- `Mailjet::Statistics_recipient_esp` for `GET /v3/REST/statistics/recipient-esp`, the replacement for `Domainstatistics` ([#276](https://github.com/mailjet/mailjet-gem/pull/276)).
- `from_ts` and `to_ts` filters on `Mailjet::Statcounters`; the `Day` and `Hour` resolutions need them ([#277](https://github.com/mailjet/mailjet-gem/pull/277)).

### Deprecated

These classes print a warning the first time they are used and will be removed in 2.0.0 ([#279](https://github.com/mailjet/mailjet-gem/pull/279)). Run Ruby with `-W0` to silence the warnings.

| Deprecated class | Replacement |
| --- | --- |
| `Newsletter` | `Campaigndraft` |
| `Newsletter_detailcontent` | `Campaigndraft_detailcontent` |
| `Newsletter_schedule` | `Campaigndraft_schedule` |
| `Newsletter_send` | `Campaigndraft_send` |
| `Newsletter_status` | `Campaigndraft_status` |
| `Newsletter_test` | `Campaigndraft_test` |
| `Apikeytotals` | `Statcounters` with `counter_source: "APIKey"` |
| `Campaigngraphstatistics` | `Statcounters` with `counter_source: "Campaign"` |
| `Campaignstatistics` | `Statcounters` with `counter_source: "Campaign"` |
| `Graphstatistics` | `Statcounters` with `counter_resolution: "Day"` or `"Hour"` |
| `Liststatistics` | `Statcounters` with `counter_source: "List"` |
| `Messagestatistics` | `Statcounters` with `counter_timing: "Message"` |
| `Openstatistics` | `Statcounters` with `counter_timing: "Message"` |
| `Senderstatistics` | `Statcounters` with `counter_source: "Sender"` |
| `Domainstatistics` | `Statistics_recipient_esp` |

### Documentation

- README guide for moving off the deprecated resources ([#280](https://github.com/mailjet/mailjet-gem/pull/280)).
- The README's PUT example uses `is_unsubscribed` instead of the legacy `is_active` ([#281](https://github.com/mailjet/mailjet-gem/pull/281)).

### Tests

- Spec for `Campaigndraft_detailcontent.find`, which returns an array, unlike `Newsletter_detailcontent.find` ([#278](https://github.com/mailjet/mailjet-gem/pull/278)).
