# tree_view_challenge

💡Solution (Asset Feature Overview)
-

I began by building the core of the app, focused on developing smaller components. The Asset feature, however, presented the most significant challenge. To handle the data retrieved from API requests, I implemented a **tree structure**. Each node in the tree holds information related to either a "Location" or an "Asset." [Source](https://github.com/tractian/challenges/tree/main/mobile) | [Figma](https://www.figma.com/design/IP50SSLkagXsUNWiZj0PjP/%5BCareers%5D-Flutter-Challenge-v2?node-id=0-1&node-type=canvas&t=1qf8I6oons3D26iJ-0).

**Node Structure:**

- **Data**: Holds the relevant information for the node.
- **Parent Node**: Reference to the parent node.
- **Children**: List of child nodes.

To render this structure in the UI, I created a recursive widget that dynamically displays the tree of nodes.


| Home      | Asset      | Asset + Filter 1
|------------|-------------|-------------|
|  <img src="https://github.com/nekomaruh/tree_view_challenge/blob/main/docs/home.png" width="250"> |  <img src="https://github.com/nekomaruh/tree_view_challenge/blob/main/docs/asset.png" width="250"> | <img src="https://github.com/nekomaruh/tree_view_challenge/blob/main/docs/asset_1.png" width="250"> 


😱 1. What Was the Real Problem? (Memory Leak)
- 
The memory heap allocated with recursive functions in the UI caused memory leaks (the app stopped working). In this example, the third company "Apex" had over 10.000 lines of data, so I was wondering how to solve the issue. At this time, I remembered how simple is to implement a ListView, so this widget could help me with garbage collection when rendering the UI (because it only renders the view that is visible in real time), so basically I transformed the Tree into a Flat Tree (a list of nodes), to show the data directly to a Listview and resolve the memory leak.

😱 2. Got Another Problem? (UI Freeze)
-
Getting the data, transformed it into classes, storing it in the tree, transforming the tree into a flat tree, you can imagine how costly this could be?. So I investigated my code and I started to modify the UI states (I thought that could be something related to it). Well, a partial solution was to fetch the data after all the widgets were initialized on the screen.

✅ 3. Solution (Isolation)
-
This approach helps to compute data in another core, so using an isolate function allowed me to run the code in another thread and also fix some UI glitches, making everything run smoother. By offloading heavy computations, the main thread stayed responsive, improving the overall user experience with large datasets.

What Would I Improve?
-
It’s hard to pinpoint specific improvements, as I believe the solution I implemented is solid. However, I would definitely seek feedback to ensure it meets all requirements and could be optimized further. One area for potential improvement is the way I approached the project’s structure. Initially, I began with the idea of an N-ary tree, but as the project evolved, the solution also mutated, and in hindsight, it may not have been the best approach.

I would reconsider the initial architecture and possibly explore using a map-based structure instead. This could simplify the UI, especially when dealing with expandable or collapsible node menus. A map structure might make handling complex datasets more efficient and easier to render, particularly for scenarios that involve heavy user interaction or large datasets.

There are also features that can be added as internationalization (multilanguage support), or theming (dark mode), or custom optimizations (more filters), but since they are not part of the requirements, I didn't add them.

What Would I Change?
-
If I had the opportunity, I would propose a backend update to improve the structure of the JSON response. By modifying the backend to return a pre-built JSON tree that mirrors the desired node structure, each entry in the response would directly map to a node in the UI tree. This would eliminate the need for costly frontend computations and significantly streamline the process of displaying the data.

Proposed Solution:

- Update the Backend JSON Structure: Change the API so that it sends back a tree structure that's ready to use, with clear parent-child relationships. This means the frontend won't have to do any extra work to organize the data; it can just display it.

- Optimize Data Flow: By moving the heavy processing tasks to the backend, the frontend can focus on what it does best—showing the data and handling user interactions. This will make the app run faster and use less memory, especially when working with large amounts of data.


I really enjoyed the process of investigating and refining the solution. Throughout the project, I implemented clean architecture and followed best practices to ensure maintainability and scalability. I’m always open to discovering more efficient ways to solve problems, especially when it comes to **performance optimization**. While everything is currently running smoothly and efficiently, I can’t help but wonder if there might be an even better approach that could further enhance performance or streamline the process.

For now, I’m satisfied with the results, but I remain curious about potential optimizations that could push the project even further.

📚 Used Dependencies
-
- [Provider](https://pub.dev/packages/provider): As Widget state manager
- [Flutter SVG](https://pub.dev/packages/flutter_svg): To load image assets in svg format
- [Dio](https://pub.dev/packages/dio): As HTTP client service
- [Get_it](https://pub.dev/packages/get_it): As a dependency injector
- [Animations](https://pub.dev/packages/animations): To switch widgets among UI states
- [Go_router](https://pub.dev/packages/go_router): To navigate between screens + route arguments

📂 Folder Structure
-
<img src="https://github.com/nekomaruh/tree_view_challenge/blob/main/docs/folder.png" width="800">


