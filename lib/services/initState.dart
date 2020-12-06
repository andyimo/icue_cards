import 'package:flutter/material.dart';
import '../models/iCueCard.dart';
import '../models/folder.dart';
import '../models/deck.dart';
import '../models/root.dart';

Root initState() {
  Root root = new Root("root");
  Folder folder = Folder("COMP 3004");
  Folder folder2 = Folder("COMP 3000");
  Folder folder3 = Folder("COMP 3007");
  Folder folder4 = Folder("COMP 3804");

  root.addFolder(folder);
  root.addFolder(folder2);
  root.addFolder(folder3);
  root.addFolder(folder4);

  Deck deck = Deck("Development Processes");
  Deck deck3 = Deck("Software Architecture");
  Deck deck4 = Deck("Architectural Styles");
  Deck deck5 = Deck("Design Patterns");
  Deck deck6 = Deck("Test 3000 Folder");
  Deck deck7 = Deck("Demo Design Patterns");

  folder.addDeck(deck);
  folder.addDeck(deck3);
  folder.addDeck(deck4);
  folder.addDeck(deck5);
  folder2.addDeck(deck6);
  folder.addDeck(deck7);

  deck4.addCard(new iCueCard(
      frontSide: 'Standard Design Strategy',
      backSide:
          'aka. Linear\n(1) Feasibility Stage: Brainstorm a set of feasible concepts. (2) Preliminary Design Stage: Select and develop the best concept. (3) Detailed Design Stage: Develop engineering descriptions of the concept. (4) Planning Stage',
      color: Colors.yellow));

  deck4.addCard(new iCueCard(
      frontSide: 'Cyclic Design Strategy',
      backSide:
          'Similar to Standard Design Strategy but can revert back to an earlier stage.',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'Parallel Design Strategy',
      backSide: 'Independent alternatives are explored in parallel',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'Adaptive Design Stategy',
      backSide:
          'The next design strategy of the design activity is decided at the end of a given stage.',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'Incremental Design Strategy',
      backSide:
          'Each stage of development is treated as a task of incrementally improving the existing design',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'Architectural Style',
      backSide:
          'Defines the components and connectors of a system (what?); not domain specific',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'Architectural Pattern',
      backSide:
          'Defines the implementation strategies of connectors and components in a system (how!); domain specific',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'Language-Based Style',
      backSide:
          'Architectural Style influenced by the programming language being used. e.g. Object-Oriented and Main-and-Subroutines',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'Main Program and Subroutines Style',
      backSide:
          'Type of Language-Based Style. Components are (1) a main program, and (2) some subroutines. Connected together by function calls. Data is passed in/out of subroutines.',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'Object-oriented Style',
      backSide:
          'Type of Language-Based Style. Objects encapsulate state and accessing functions. State is strongly encapsulated. Not particularly efficient.',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'Layered Style',
      backSide:
          'Each layer exposes an API to be used by the layers above it. Each layer acts as a client (service consumer of the layer below) and a server (service provider to the layer above).',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'Strict Layering',
      backSide:
          'Type of Layered Architectural Style. A top layer can only use the resources/API of the layer directly below it.',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'Nonstrict Layering',
      backSide:
          'Type of Layered Architectural Style. A top layer can acccess the resources and API of any layer below it.',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'Client-Server Style',
      backSide:
          'Type of Layered Architectural Style. Only two layers (client and server). Client initates communication by sending server a request. Server performs the requested action and replies.'));
  deck4.addCard(new iCueCard(
      frontSide: 'Virtual Machines',
      backSide:
          'Type of Layered Architectural Style. Ordered sequence of layers, each layer offering services to be used by programs residing in the layer(s) above it.',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'Dataflow Style',
      backSide:
          'Architectural style with a focus on how data moves between processing elements',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'Batch-Sequential Style',
      backSide:
          'Type of Dataflow Style. Separate programs executed in rigid order. Aggregated data (on magnetic tape) transferred by the user from one program to another)'));
  deck4.addCard(new iCueCard(
      frontSide: 'Pipe and Filter',
      backSide:
          'Type of Dataflow Style. Separate programs are executed (potentially concurrently). Independent programs (components) are connected by pipes (routers of data streams) provided by the OS',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'BlackBoard Style',
      backSide:
          'Type of Shared Memory Style. Separate programs (aka Knowledge Sources) that communicate through a shared repository called the Blackboard. ',
      color: Colors.yellow));
  deck4.addCard(new iCueCard(
      frontSide: 'Interpreter Style',
      backSide:
          'Translates source code into an executable one instruction at a time. Parses and executes input commands, updating the state maintained by the interpreter.',
      color: Colors.yellow));

  deck3.addCard(new iCueCard(
      frontSide: 'Software Architecture',
      backSide:
          'Set of principle design decisions governing a software system (structure, behaviour, interaction, non-functional properties)',
      color: Colors.yellow));
  deck3.addCard(new iCueCard(
      frontSide: 'Prescriptive Architecture',
      backSide:
          'Dictates how the system will be build a priori (as-conceived/as-intended)',
      color: Colors.yellow));
  deck3.addCard(new iCueCard(
      frontSide: 'Descriptive Architecture',
      backSide:
          'Describes how the system has actually been built (as-implemented/as-realized)',
      color: Colors.yellow));
  deck3.addCard(new iCueCard(
      frontSide: 'Architectural Degradation',
      backSide:
          'Adding new design decisions to an architecture that deviate from the Prescriptive Architecture. e.g. Architectural Drift and Architectural Erosion',
      color: Colors.yellow));
  deck3.addCard(new iCueCard(
      frontSide: 'Architecutral Drift',
      backSide:
          'The addition of new design decisions that aren\'t part of the Prescriptive Architecture but does not violate the overall design decisions',
      color: Colors.yellow));
  deck3.addCard(new iCueCard(
      frontSide: 'Architectural Erosion',
      backSide:
          'Incorporation of design decisions that VIOLATE the Prescriptive Architecture.',
      color: Colors.yellow));
  deck3.addCard(new iCueCard(
      frontSide: 'Architectural Recovery',
      backSide:
          'The act of reviewing the entire codebase to determine a software system\'s architecture.',
      color: Colors.yellow));
  deck3.addCard(new iCueCard(
      frontSide: 'Components',
      backSide:
          'Architectural entity that encapsulates a subset of the system functionality, restricts access via explicit interface, has explicit environmental dependencies',
      color: Colors.yellow));
  deck3.addCard(new iCueCard(
      frontSide: 'Connectors',
      backSide:
          'Architectural entity tasked with effecting and regulating interactions among components (e.g. procedure calls or shared data access)',
      color: Colors.yellow));
  deck3.addCard(new iCueCard(
      frontSide: 'Configuration',
      backSide:
          'aka. Topology\nSet of specific associations between components and connectors.',
      color: Colors.yellow));

  deck5.addCard(new iCueCard(
      frontSide: 'Design Pattern',
      backSide:
          'Typical solution to common problems in software design.\nThink of it like a blueprint you can customize to solve a particular design problem in your code.',
      color: Colors.grey));
  deck5.addCard(new iCueCard(
      frontSide: 'Creational Design Pattern',
      backSide:
          'Design pattern that provides various object cretion mechanisms, which increase flexibility and reuse of existing code.',
      color: Colors.green));
  deck5.addCard(new iCueCard(
      frontSide: 'Structural Design Pattern',
      backSide:
          'Design pattern that explains how to assemble objects and classes into larger structures while keeping these structures flexible and efficient',
      color: Colors.red));
  deck5.addCard(new iCueCard(
      frontSide: 'Behavioural Design Pattern',
      backSide:
          'Design pattern concerned with algorithms and assignment of responsibility between objects.',
      color: Colors.indigo));
  deck7.addCard(new iCueCard(
      frontSide: 'Creational Design Pattern',
      backSide:
          'Design pattern that provides various object cretion mechanisms, which increase flexibility and reuse of existing code.',
      color: Colors.green));
  deck7.addCard(new iCueCard(
      frontSide: 'Structural Design Pattern',
      backSide:
          'Design pattern that explains how to assemble objects and classes into larger structures while keeping these structures flexible and efficient',
      color: Colors.red));
  deck7.addCard(new iCueCard(
      frontSide: 'Behavioural Design Pattern',
      backSide:
          'Design pattern concerned with algorithms and assignment of responsibility between objects.',
      color: Colors.indigo));
  deck5.addCard(new iCueCard(
      frontSide: 'Singleton',
      backSide:
          'Creational Design Pattern.\nLets you ensure that a class has only one instance, while providing a global access point to this instance.\nWhy use it: Provides stricter access to shared resources (like a database or a file). Great if clients should all be sharing a single instance of a class.',
      color: Colors.purple));
  deck5.addCard(new iCueCard(
      frontSide: 'Observer',
      backSide:
          'Behavioural Design Pattern.\n(aka. Event-Subscriber, Listener)\nLets you define a subscription mechanism to notify multiple objects about any events that happen to the object they are observing.',
      color: Colors.brown));
  deck5.addCard(new iCueCard(
      frontSide: 'Composite',
      backSide:
          'Structural Design Pattern.\nLets you compose objects into tree structures and then work with these structures as if they were individual objects. This pattern is useful if you want the client code to treat both simple and complex elements uniformly.',
      color: Colors.black));
  deck5.addCard(new iCueCard(
      frontSide: 'Strategy',
      backSide:
          'Behavioural Design Pattern.\nLets you define a family of algorithms, put each of them into a separate class, and make their objects interchangeable.',
      color: Colors.yellow));
  deck5.addCard(new iCueCard(
      frontSide: 'Adaptor',
      backSide:
          'Structural Design Pattern.\n(aka. Wrapper)\nAllows objects with incompatible interfaces to collaborate. (e.g. a wrapper that converts XML files into JSON format to be passed into an Analytics library)',
      color: Colors.greenAccent));
  deck5.addCard(new iCueCard(
      frontSide: 'Facade',
      backSide:
          'Structural Design Pattern.\nProvides a simplified interface to a library, frameowkr or any complex set of classes. Use when you need an interface that is more straightforward and to the point.',
      color: Colors.teal));
  deck5.addCard(new iCueCard(
      frontSide: 'Template Method',
      backSide:
          'Behavioural Design Pattern.\nDefines the skeleton of an algorithm in the superclass but lets subclasses override specific steps of the algorithm without changing its structure. Use when several classes have similar algorithms with minor differences.',
      color: Colors.red[900]));
  deck5.addCard(new iCueCard(
      frontSide: 'Iterator',
      backSide:
          'Behavioural Design Pattern.\nLets you traverse elements of a collection without exposing its underlying representation (list, stack, tree, etc.). The main idea is to extract the traversal behaviour of a collection into a separate object.',
      color: Colors.pink));
  deck5.addCard(new iCueCard(
      frontSide: 'Decorator',
      backSide:
          'Structural Design Pattern.\nLets you attach new behaviours to objects by replacing these objects inside special wrapper objects that contain the behaviours. e.g. Assign extra behaviours to objects at runtime without breaking the code that uses these objects.',
      color: Colors.orange));

  deck.addCard(new iCueCard(
      frontSide: 'Heavyweight Process',
      backSide:
          'Type of Software Engineering Process that is document driven, has many different roles, checkpoints, highly bureaucratic',
      color: Colors.blue,
      image: AssetImage('assets/long.png')));

  deck.addCard(new iCueCard(
      frontSide: 'Software Engineering Process',
      backSide:
          'Template for organizing tasks and people in a project. Define who does what, when and how in the development of a software system. Has roles, workflows, milestones and guidelines.',
      color: Colors.green,
      image: AssetImage('assets/1.jpg')));
  deck.addCard(iCueCard(
      frontSide: "Lightweight Process",
      backSide:
          ' Type of Software Engineering Process with focus on working code rather than documentation/Direct communication between client and developer/Low management overhead',
      color: Colors.amber,
      image: AssetImage('assets/width.jpg')));

  deck.addCard(new iCueCard(
      frontSide: 'Waterfall',
      backSide:
          'Linear, sequential Software Engineering Process with 5 phases: Requirements, Design, Implementation, Verification, Maintenance. Very costly to revisit a previous stage.',
      color: Colors.yellow));
  deck.addCard(new iCueCard(
      frontSide: 'Spiral',
      backSide:
          'Iterative Software Engineering Process. Used for high risk projects. This process is divided into 4 quadrants (Identify objective and constraints, Analyze and mitigate risks, Execution and testing, Review Progress and plan for next phase).',
      color: Colors.yellow));
  deck.addCard(new iCueCard(
      frontSide: 'RUP (Rational Unified Process)',
      backSide:
          'Iterative Software Engineering Process created by Rational Software Corporation (IBM). Use case driven and architecture centric. Contains 4 phases(Inception, Elaboration, Construction, Transition)',
      color: Colors.yellow));
  deck.addCard(new iCueCard(
      frontSide: '4+1 View Model',
      backSide:
          'Defines the architecture of a system from 5 perspectives (Implementation/Development view, Logical/Analytical View, Physical/Deployment view, Process view, Use-Case view)',
      color: Colors.yellow));
  deck.addCard(new iCueCard(
      frontSide: 'Agile',
      backSide:
          'Aka lightweight process. Can accomodate changing requirements, Customer collaboration, has less documentation',
      color: Colors.yellow));
  deck.addCard(new iCueCard(
      frontSide: 'XP (Xtreme Programming)',
      backSide:
          'An Agile software engineering process. No design up front. Write test cases before writing code. Pair programming + refactoring.',
      color: Colors.yellow));
  deck.addCard(new iCueCard(
      frontSide: 'The Planning Game',
      backSide:
          '[XP] Stakeholder meeting to plan the next iteration. Business people decide on business values of features. Developers on the technical risk of features and predicted effort per feature.',
      color: Colors.yellow));
  deck.addCard(new iCueCard(
      frontSide: 'Pair Programming',
      backSide:
          'All production code written by 2 programmers. One programmer is thinking about the implementation of a method while the other thinks strategically about the whole system. Pairs are put together and shuffled dynamically.',
      color: Colors.yellow));
  deck.addCard(new iCueCard(
      frontSide: 'SCRUM',
      backSide:
          'An agile process. Based on Rugby. Emphasis on helping teams work together. Encourages team to learn through experiences, self-organize while working on a problem, and reflect on the successes and failures to continuously improve. The three main roles in are the ScrumMaster, Product owner, team of 3-9 people.',
      color: Colors.yellow));
  deck.addCard(new iCueCard(
      frontSide: 'Scrum Master',
      backSide:
          'Acts as a facilitator, distraction remover, proces cop. Is NOT the team leader. ',
      color: Colors.yellow));
  deck.addCard(new iCueCard(
      frontSide: 'Sprints',
      backSide:
          'An iteration of SCRUM. At the end of every sprint, the team has a shippable product that is demoed to the product owner. Update sprint backlog. Happens every 2-4 weeks. ',
      color: Colors.yellow));
  deck.addCard(new iCueCard(
      frontSide: 'Product Backlog',
      backSide:
          'SCRUM artifact. High level document created for the entire project. Contains the list of features to be implemented with an associated priority/business value and a development effort value.',
      color: Colors.yellow));
  deck.addCard(new iCueCard(
      frontSide: 'Sprint Backlog',
      backSide:
          'SCRUM artifact. Contains info about how the team is going to implement features for an upcoming sprint. Features are broken down into tasks (about 4-6 hrs of work), team members sign up for tasks voluntarily. A Task Board monitors the progress of each task',
      color: Colors.yellow));
  deck.addCard(new iCueCard(
      frontSide: 'Burn Down Chart',
      backSide:
          'SCRUM artifact. Shows the remaining work in the sprint backlog (updated daily).',
      color: Colors.yellow));
  deck.addCard(new iCueCard(
      frontSide: 'Daily Scrum',
      backSide:
          ' A daily project status meeting about 15 imuntes (standing up). 3 questions: What have you done? what are you working on today? Any challenges?',
      color: Colors.yellow));

  return root;
}
