# tree_view_challenge

💡Solution (Asset Feature Overview)
-

I started by laying the foundation of the app, focusing on smaller components. The Asset feature, however, presented the most significant challenge. To handle the data retrieved from API requests, I implemented a **tree structure**. Each node in the tree holds information related to either a "Location" or an "Asset." [Source](https://github.com/tractian/challenges/tree/main/mobile) | [Figma](https://www.figma.com/design/IP50SSLkagXsUNWiZj0PjP/%5BCareers%5D-Flutter-Challenge-v2?node-id=0-1&node-type=canvas&t=1qf8I6oons3D26iJ-0).

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
The main issue was a memory leak caused by the memory heap allocation in a recursive function. In one particular case, the third company, "Apex," had over 10,000 lines of data, which led to significant performance concerns.

To address this, I recalled how effective the ListView widget can be for managing memory. Since ListView only renders visible items in real-time, it helps with garbage collection and memory optimization. I decided to transform the tree structure into a Flat Tree (a list of nodes) and display the data directly within a ListView to resolve the memory leak.

😱 2. Got Another Problem? (UI Freeze)
-
The process of fetching data, transforming it into classes, storing it in a tree structure, and then converting it into a flat tree turned out to be quite resource-intensive. As you can imagine, this led to performance issues, particularly UI freezes.

To address this, I reviewed my code and initially focused on modifying the UI states, thinking that might be part of the problem. While that didn't fully solve it, a partial solution was to delay the data fetching until after all the widgets were initialized on the screen, reducing the load during the UI rendering process.

✅ 3. Solution (Isolation)
-
To overcome the performance issues and UI freezes, I implemented a solution based on isolation. This approach allows for offloading heavy computations to another core, thus freeing up the main thread (where the UI runs) from resource-intensive tasks.

By leveraging Dart's Isolate functionality, I was able to move the data processing logic—such as transforming the hierarchical tree structure into a flat list—into a separate thread. This significantly reduced the computational load on the main thread, which in turn improved the responsiveness of the UI. With this method, the heavy lifting happens in the background, preventing UI glitches and ensuring smooth interactions.

This not only resolved the memory leak issues but also allowed for a more scalable solution, capable of handling large datasets without freezing the interface. The result is a more fluid user experience and efficient use of system resources.

What Would I Improve?
-
It’s hard to pinpoint specific improvements, as I believe the solution I implemented is solid. However, I would definitely seek feedback to ensure it meets all requirements and could be optimized further. One area for potential improvement is the way I approached the project’s structure. Initially, I began with the idea of an N-ary tree, but as the project evolved, the solution also mutated, and in hindsight, it may not have been the best approach.

I would reconsider the initial architecture and possibly explore using a map-based structure instead. This could simplify the UI, especially when dealing with expandable or collapsible node menus. A map structure might make handling complex datasets more efficient and easier to render, particularly for scenarios that involve heavy user interaction or large datasets.

There are also features that can be added as internationalization (multilanguage support), or theming (dark mode), or custom optimizations (more filters), but since they are not part of the requirements, I didn't add them.

What Would I Change?
-
If I had the opportunity, I would propose a backend update to improve the structure of the JSON response. By modifying the backend to return a pre-built JSON tree that mirrors the desired node structure, each entry in the response would directly map to a node in the UI tree. This would eliminate the need for costly frontend computations and significantly streamline the process of displaying the data.

Proposed Solution:

Update Backend JSON Structure: Modify the API to return a ready-to-use tree structure, with parent-child relationships already established. This way, the frontend would only need to parse and render the data, without transforming it.
Optimize Data Flow: By shifting the heavy lifting to the backend, the frontend can become leaner, focusing purely on presentation and interaction. This would improve performance and reduce memory usage, especially when dealing with large datasets.


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


