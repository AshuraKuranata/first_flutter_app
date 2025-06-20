// import 'dart:ffi';

// import 'package:english_words/english_words.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// // The acutal code that calls the app to activate
// void main() {
//   runApp(MyApp());
// }

// extension StringExtension on String {
//   String capitalizeByWord() {
//     if (trim().isEmpty) {
//       return '';
//     }
//     return split(' ')
//       .map((element) => "${element[0].toUpperCase()}${element.substring(1).toLowerCase()}")
//       .join(" ");
//   }
// }

// // Widgets are the elements that Flutter apps are built on (Stateless vs Stateful widgets)
// // The class that sets up and prepare the whole app across the whole page
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => MyAppState(),
//       child: MaterialApp(
//         title: 'Namer App',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
//         ),
//         home: MyHomePage(),
//       ),
//     );
//   }
// }

// // Class that sets the current state of the application
// // In this case, this is setting up a random word pair generation, but useful for many other set-ups 
// class MyAppState extends ChangeNotifier {
//   var current = WordPair.random();
//   void getNext() {
//     current = WordPair.random(); // Generates a new WordPair
//     notifyListeners(); // Tells any watchers of the MyAppState to update when the method/function is called
//   }

//   // Adding code for a like button 
//   // var favorites = <WordPair>[]; // This is for a List.
//   var favorites = <WordPair>{}; // This is for a Set (objects)

//   void toggleFavorite() {
//     if (favorites.contains(current)) {
//       favorites.remove(current);
//     } else {
//       favorites.add(current);
//     }
//     notifyListeners();
//   }

// }

// // Main Application View
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) { // build() calls everytime the widget changes to keep it up to date (builds itself over)
//     var appState = context.watch<MyAppState>(); // "context.watch<>" call checks the app's current state of the MyAppState (this can be replaced)
//     var pair = appState.current;

//     IconData icon;
//     if (appState.favorites.contains(pair)) {
//       icon = Icons.favorite;
//     } else {
//       icon = Icons.favorite_border;
//     }

//     return Scaffold( // All Widgets MUST RETURN something, usually another widget or nested tree of widgets.  In this case, using a Scaffold() which is used on many Flutter Apps 
      
//       // One of the most basic and common layouts of a widget.  Takes all children that exist under it and set them on top of each other in a column from top to bottom.
//       // Think of a column in the same format of a bucket/container/holder in HTML like a <div> or <section> etc.
//       body: Center( // Refactor the column by wrapping it with Center
//         child: Column( 
//           mainAxisAlignment: MainAxisAlignment.center, // Centering column in the app
//           children: [
//             // Text('Cool idea to change it:'), // Text() calls to add text to the actual app when initialized
//             // Text(appState.current.asPascalCase), // This calls on the variable appState that is watching the context of MyAppState that has the variable 'current' which is randomly creating a WordPair from the class, and then lower casing  
//             // Text(pair.asPascalCase) // Updated widget to only call what is needed.
            
//             BigCard(pair: pair), // Refactored the widget and extracted it to its own widget (class).  This allows it to be adjusted separately to keep main code clean
//             // Refactoring: Right click or highlight and hit 'ctrl+shift+R'; select "Extract as Widget" and give a new name
//             SizedBox(height: 10),
//             // Code for button in app
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Button(appState: appState),
//                 SizedBox(width: 10),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     appState.toggleFavorite();
//                   },
//                   icon: Icon(icon),
//                   label: Text('Like'),
//                 ),
//               ],
//             )
//             ],
//         ),
//       ),
//     );
//   }
// }

// class Button extends StatelessWidget {
//   const Button({
//     super.key,
//     required this.appState,
//   });

//   final MyAppState appState;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     final style = theme.textTheme.bodySmall!.copyWith(
//       color: theme.colorScheme.onSecondary,
//     );

//     return ElevatedButton(
//       style: ButtonStyle(
//         backgroundColor: WidgetStateColor.resolveWith(
//           (Set<WidgetState> states) {
//             if (states.contains(WidgetState.hovered)) {
//               return theme.colorScheme.secondary;
//             }
//             return theme.colorScheme.primary;
//           }
//         ),
//       ),
      
//       // style: ElevatedButton.styleFrom( // Need to use call of styleFrom 
//       //   backgroundColor: theme.colorScheme.secondary
//       // ),
//       onPressed: () {
//         appState.getNext(); // Calls the class MyAppState function getNext().  Cannot call the class directly 'MyAppState.getNext()'
//         // print('button pressed!'); // Console Command, can use this like console.log in terminal/node to help with debugging
//       },
//       child: Text('Next', style: style), // child that adjusts the text within the button
//     );
//   }
// }

// class BigCard extends StatelessWidget {
//   const BigCard({
//     super.key,
//     required this.pair,
//   });

//   final WordPair pair;

//   @override
//   // More Refactoring: call the refactor menu and select "Wrap with Padding", which creates a padding widget around the text (like padding in CSS)
//   Widget build(BuildContext context) {
//     // Adjusting theme of the BigCard Widget: good practice to keep using a consistent color scheme across an application
//     final theme = Theme.of(context); // This calls the theme of the app
    
//     // Adjusting style of text in app
//     // Calling the app's font themes, allowing to call on things like Body/Display/captions/headlines etc. *LOOK UP FOR MORE OPTIONS!
//     // displayMedium can be null, using Dart.  Dart is null-safe, which prevents calling methods of objects that might be null.  Use the ! operator to override Dart's function.
//     // copyWith gives a copy of text style and adds in whatever is being called in the function.
//     final style = theme.textTheme.displayMedium!.copyWith(
//       color: theme.colorScheme.onSecondary,

//     );

//     var firstWord = pair.first.capitalizeByWord();
//     var secondWord = pair.second.capitalizeByWord();

//     // Refactor Padding with a widget called "Card", this wraps the Padding and Text with the Card widget that can utilize the theme of the app!
//     return Card(
//       color: theme.colorScheme.primary, // This calls the primary colorScheme of the app 
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(20.0), // EdgeInsets.all(##.##) adds in the sizing around 
//         child: Text(
//           "${firstWord} ${secondWord}",
//           style: style,
//           semanticsLabel: "${pair.first} ${pair.second}",
//           ), // Adding the style as style
//       ),
//     );
//   }
// }



// // REMEMBER YOUR TRAILING COMMAS, DART IS VERY STRICT TO REQUIRE IT TO KEEP CODE RUNNING
// // Flutter best practices: when you are working in more complex applications, break down widgets based on their logical parts to make manageable and understandable
