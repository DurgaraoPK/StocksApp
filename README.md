# Stock App (iOS - SwiftUI, MVVM)

A simple iOS application that displays stock market data including a list of stocks and detailed information for each stock.

---

## Features

- Stock List Screen
  - Displays stock name, symbol, price, and percentage change
  - Auto-refresh every 8 seconds

-  Search Functionality
  - Filter stocks by name in real-time

-  Stock Detail Screen
  - View additional information about a selected stock

-  Real-time Data Fetching
  - Uses async/await for network calls

-  Clean Architecture
  - MVVM (Model-View-ViewModel)
  - Manual Dependency Injection (no third-party DI frameworks)

-  Unit Testing
  - ViewModel test coverage with mock repository

---

##  Tech Stack

- Swift
- SwiftUI
- MVVM Architecture
- Swift Concurrency (async/await)
- URLSession (Networking)
- XCTest (Unit Testing)

---

##  API

Due to issues with the originally provided RapidAPI endpoint (unavailable at the time of development), this project uses:

- **Finnhub API** (free stock market API)

### APIs Used:
- `/quote` → Get stock price and change %
- `/stock/profile2` → Get company details
- `/stock/symbol` → Get list of stock symbols

---

##  Limitations

- Only a limited set of stocks are displayed (due to API constraints)
- No pagination support from API
- Market cap / P/E ratio not available in free tier
- Symbol list is partially restricted for performance

---
