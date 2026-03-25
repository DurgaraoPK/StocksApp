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


- "/market/v2/get-summary"
- "/stock/v2/get-summary"

---

##  Limitations

-  I didn't get proper response or Json body when i hit the /stock/v2/get-summary API and getting this below error 

  " data couldn’t be read because it isn’t in the correct format. "
 
---
