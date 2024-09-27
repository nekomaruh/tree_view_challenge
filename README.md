# tree_view_challenge

This is a solution for the Tractian Tree View challenge: [Source](https://github.com/tractian/challenges/tree/main/mobile) | [Figma](https://www.figma.com/design/IP50SSLkagXsUNWiZj0PjP/%5BCareers%5D-Flutter-Challenge-v2?node-id=0-1&node-type=canvas&t=1qf8I6oons3D26iJ-0).

💡Solution (Asset Feature Overview)
-

I began by building the core of the app, focused on developing smaller components. The Asset feature, however, presented the most significant challenge. To handle the data retrieved from API requests, I implemented a **tree structure**. Each node in the tree holds information related to either a "Location" or an "Asset."

**Node Structure:**

- **Data**: Holds the relevant information for the node.
- **Parent Node**: Reference to the parent node.
- **Children**: List of child nodes.

To render this structure in the UI, I created a recursive widget that dynamically displays the tree of nodes. 

Here is the UI solution **(real images)**:

| Home      | Asset      | Asset + Button Filter 1      | Asset + Text Filter
|------------|-------------|-------------|-------------|
|  <img src="https://github.com/nekomaruh/tree_view_challenge/blob/main/docs/home.png" width="250"> |  <img src="https://github.com/nekomaruh/tree_view_challenge/blob/main/docs/asset.png" width="250"> | <img src="https://github.com/nekomaruh/tree_view_challenge/blob/main/docs/asset_1.png" width="250"> | <img src="https://github.com/nekomaruh/tree_view_challenge/blob/main/docs/asset_4.png" width="250"> 


😱 1. What Was the Real Problem? (Memory Leak)
- 
The memory heap allocated with recursive functions in the UI caused memory leaks (the app stopped working). In this example, the third company "Apex" had over 10,000 lines of data, so I was wondering how to solve the issue.

At this time, I remembered how simple is to implement a ListView, so this widget could help me with garbage collection when rendering the UI (because it only renders the view that is visible in real time), so basically I transformed the Tree into a Flat Tree (a list of nodes), to show the data directly to a Listview and resolve the memory leak.

😱 2. Got Another Problem? (UI Freeze)
-
Getting the data, transformed it into classes, storing it in the tree, transforming the tree into a flat tree, you can imagine how costly this could be?. So I investigated my code and I started to modify the UI states (I thought that could be something related to it). Well, a partial solution was to fetch the data after all the widgets were initialized on the screen.

✅ 3. Solution (Isolation)
-
This approach helps to compute data in another core, so using an isolate function allowed me to run the code in another thread and also fix some UI glitches, making everything run smoother. By offloading heavy computations, the main thread stayed responsive, improving the overall user experience with large datasets.

I have created a table showing the compute response time of creating the tree and generating filters with 10 retry times:

| Company     | Location Nodes     | Asset Nodes      | Total Nodes       | Compute Time (iPhone 15 debug)
|------------|-------------|-------------|-------------|-------------|
| Jaguar | 4 | 9 | 13 nodes | 0.494 to 0.870 seconds
| Tobias | 38 | 83 | 121 nodes | 0.520 to 0.841 seconds
| Apex | 3,792 | 14,617 | 18,409 nodes | 2.422 to 2.713 seconds

🔎 How the search filter works?
-
One of the requirements was: *"***When the filters are applied, the asset parents can't be hidden. The user must know the entire asset path. The items that are not related to the asset path, must be hidden.***"*

‼️ So the user should see the entire asset path even the children when filtering. ‼️

**Button Filter:** The data will be displayed in this unique case:
1. All the assets containing the data, will show the data and all the parents on the tree

**Text Filter:** The data will be displayed in this 3 cases:
1. If the node contains the text
2. If the node does not contain the *text*, it will search the parents and if found, all of the parents will be displayed
3. If the node does not contain the *text*, it will search the children and if found, all of the children will be displayed

**Combination:**
- The Button Filter will be applied first and Text filter over it.

🚀 What Would I Improve?
-
It’s hard to say what could be improved because I consider that it's a good solution, I would really ask for feedback. I'll probably improve the way I carried out the project ideas. I started with the idea of an N-ary tree, but then it mutated as I resolved the problem, which may not have been the best solution in hindsight.

I might apply a map-based structure to display the information (this would help me simplify the UI in case it’s necessary to expand or collapse the node menu). There are also features that can be added:

- Permission handling for networking
- Map Success/Error states for API calls (now is only working with try catch and getting errors as strings)
- Expansible tab in UI tree
- Centralized asset texts for loading images
- Centralized variable texts to work with internationalization (multilanguage support)
- Theming (Dark Mode)
- Custom optimizations (more filters)
- Unit testing
- An option to show only parents or only childrens in text filter

Since those features are not part of the requirements, I didn't add them.


🤔 What Would I Change?
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


