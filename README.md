# Mintyn

A Flutter implementation of the Dashboard (Home) and Cards screens from the assessment's
Figma design, extended to include Transactions and Profile, wired to mocked data with a
simulated real-time feed for live balance and transaction updates.

<!-- Add your emulator recording here before submitting:
![demo](docs/demo.gif)
-->

## Getting started

```bash
# 1. Install dependencies
flutter pub get

# 2. Run the app
flutter run

# 3. Run the test suite
flutter test
```

## Google drive link (Emulator recording)
https://drive.google.com/file/d/1t-RzeueUk8Z_Y0UXtNaFtBgTbdKkzjqg/view?usp=share_link



## Screens implemented

- **Home** — live balance card, recent transaction preview
- **Card** — physical/virtual card toggle, swipeable card carousel, 
  card settings
- **Card Transactions** — per-card transaction history + spend chart, reached by tapping a
  card or the "Card Transactions" settings row
- **Transactions** — filterable (Today / Weekly / Monthly) transaction list with live inserts
- **Profile** — user info
- **Drawer** — shared navigation, profile shortcuts

## Architecture

```
lib/
├── core/
│   ├── constants/         # color tokens, shared constants
│   ├── model/              # CardModel, TransactionModel,
│   ├── services/           # MockTransactionService, , RealtimeService
│   └── app_theme.dart
├── views/
│   ├── homepage/
│   │   ├── homepage.dart
│   │   ├── provider/        # TransactionProvider, BalanceProvider
│   │   └── widgets/         # CardBalance, AppDrawer, TransactionList
│   ├── card/                # CreditCard screen + CardCarousel/CardFace widgets
│   ├── card_transaction/    # CardTransactions screen + SpendChartCard
│   ├── profile/
│   └── shared_widgets/      # Header, ProfileContainer, SettingsRow, ConnectionBanner
└── main.dart
```

**Pattern: Provider (ChangeNotifier), repository-style service layer underneath.**
Screens only ever talk to a `Provider` (`context.watch`/`context.read`). Providers only ever
talk to a `Service` interface (`MockTransactionService`, `MockUserService`), never a data
source directly. This means swapping mocked services for real HTTP-backed ones later is a
change isolated to the service layer — no provider or widget code needs to change.

Each data domain (transactions, user, balance) follows the same three-layer shape:
`Model` (plain Dart) → `Service` (fetches/returns data) → `Provider` (ChangeNotifier holding
state + business logic, exposed to widgets).

### Real-time data

`RealtimeService` simulates a live payments connection: it periodically emits a new mocked
transaction (~every 10s) and randomly drops the connection (~10% chance per tick) to exercise
reconnect/error-handling paths, recovering automatically after a few seconds.

Rather than ticking the balance independently, **the balance is derived from the live
transaction feed** — `BalanceProvider` and `TransactionProvider` both subscribe to the same
`RealtimeService.transactionStream`, so a new transaction simultaneously updates the running
balance and appears in the transaction list. This keeps the two visibly connected instead of
being two unrelated random processes.

`ConnectionStatus` (`connecting` / `connected` / `disconnected` / `reconnecting`) is exposed
by both providers and surfaced via a shared `ConnectionBanner` widget wherever live data is
displayed (Home, Transactions, Card Transactions), so a dropped connection is visible to the
user rather than silently freezing.

Each provider subscribes to the stream independently and only calls `notifyListeners()` in
response to its own relevant events — a balance update doesn't rebuild the transaction list,
and vice versa.

### State handling

Every provider follows the same `ViewState` (`idle` / `loading` / `loaded` / `error`) pattern,
so every screen consistently shows a loading indicator on first fetch, a retry-able error
view on failure, and the real content once loaded — implemented once per provider rather than
duplicated per screen.

### Animations

- Balance figure cross-fades/counts on load and on each live update
- New transactions animate into the list with a staggered fade + slide-in
- Card carousel: center card scales up, side cards peek in with a subtle shrink, animated
  page-dot indicator
- Card number/CVV reveal, freeze toggle, and filter chip selection all animate their state
  changes rather than snapping
- Profile screen sections cascade in with staggered fade + slide on first load
