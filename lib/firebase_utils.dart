import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/model/task.dart';

class FirebaseUtils {
  // static void addTaskToFireStore() {
  //   // .instance create object from FirebaseFirestore
  //   // .collection => search about collection name, if found get it, if don't found, it will create it
  //   // withConverter => make firebase knows the type of data that i store
  //   // Task.collectionName instead of 'tasks' - same as routeName
  //   FirebaseFirestore.instance.collection(Task.collectionName).withConverter<Task>(
  //     // get data from firebase that stored in json doc , so get document and then get its data
  //     fromFirestore: (snapshot, options) => Task.fromFireStore(snapshot.data()!),
  //     // send data to firebase, i have object so convert it to json
  //     toFirestore: (task, options) => task.toFirestore());
  // }

  // OR function to create collection(for tasks) with the type of its data
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFirestore());
  }

  static Future<void> addTaskToFireStore(Task task) {
    var taskCollection = getTasksCollection(); // create & get collection
    var taskDocRef = taskCollection
        .doc(); // create doc - give it id or it will generate auto-id
    task.id = taskDocRef.id; // auto-id
    return taskDocRef
        .set(task); // to make isDone = true - store task in firebase
  }

  // OR Task task + getTasksCollection().doc(task.id)
  static Future<void> deleteTaskFromFireStore(Task task, String id) {
    return getTasksCollection().doc(id).delete();
  }

  // update -- edit
  static Future<void> updateTaskFromFireStore(Task task) {
    return getTasksCollection().doc(task.id).update({
      'title' : task.title,
      'description' : task.description,
      'dateTime' : task.dateTime
    });

    
  }
}
