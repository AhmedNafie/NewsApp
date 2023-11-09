# NewsApp

An application used to fetch recent news based on NewsAPI V2 and supports offline mode with your last loaded articles.

## Features

### Viewing and rating articles:
<img width=25% src=https://github.com/AhmedNafie/NewsApp/assets/101005449/3a7e874f-391c-42cb-95d4-cc15f5b3c7cf>

### Handling online and offline modes:
<img width=25% src=https://github.com/AhmedNafie/NewsApp/assets/101005449/8b8c96eb-b713-4396-9d9d-4e7089a6af9a>
<img width=25% src=https://github.com/AhmedNafie/NewsApp/assets/101005449/313ff4b0-ac11-40a1-8e77-0623cc21dcd0>

### Handling different errors:
<img width=25% src=https://github.com/AhmedNafie/NewsApp/assets/101005449/726925b8-e81f-4a61-968e-c54aa684c1ba>
<img width=25% src=https://github.com/AhmedNafie/NewsApp/assets/101005449/d4bc18aa-d58f-4afa-9e9f-f9720c537de3>

### Rating validation:
<img width=25% src=https://github.com/AhmedNafie/NewsApp/assets/101005449/c8aed022-4a1e-4298-a896-aeb95a7c37bb>
<img width=25% src=https://github.com/AhmedNafie/NewsApp/assets/101005449/8b468985-64a2-4f77-8c53-3f8e754354cd>


## Technologies used

### Dependency Manager: _Swift Package Manager_
### Dependencies: _IQKeyboardManagerSwift_
### Architecture: _MVC_
### Design Patterns: _Singleton_
### Notes:
 * Using `Reachability` to check network status.
 * Using `CoreData` for data persistence.
 * Prefer strongly typed values by:
    * Using `Constants` enum to hold all the constants in the app.
    * `UITableView` extensions to register and dequeue cells.
