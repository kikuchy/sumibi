# Sumibi

![sumibi_logo](./art/logo.jpg)

**Sumibi** is thin [could_firestore](https://pub.dev/packages/cloud_firestore) wrapper.

Sumibi can inject your own hooks on calling of `setData`/`set` and `updateData`/`update`.

## Usage

```dart
final sumibi = SumibiFirestore(
  Firestore.instance,
  onSetDataHook: (String documentPath, Map<String, dynamic> data) {
    data["createdAt"] = FieldValue.serverTimestamp();
    data["updatedAt"] = FieldValue.serverTimestamp();
  },
  onUpdateDataHook: (String documentPath, Map<String, dynamic> data) {
    data["updatedAt"] = FieldValue.serverTimestamp();
  },
);

// Now `user` have properties `name`, `createdAt` and `updatedAt`.
final user = await sumibi.collection("/users").add({"name": "John"});

// Now `user.name` will be "Alex" and `user.updatedAt` will be updated. 
await user.updateData({"name": "May"});

final friends = user.collection("/friends");
await sumibi.batch()
  // Also `createdAt` and `updatedAt` will be created.
  ..setData(friends.document("/a"), {"name": "Alex"})
  ..setData(friends.document("/b"), {"name": "Bob"})
  // `user.updatedAt` will be updated.
  ..updateData(user, {"numOfFriends": 2})
  ..commit();

sumibi.runTransaction((transaction) {
  // After this transaction, `user.updatedAt` will be updated.
  transaction.update(user, {"likeCount": FieldValue.increment(1)});
});
```

`SumibiFirestore` implements [`Firestore`](https://pub.dev/documentation/cloud_firestore/latest/cloud_firestore/Firestore-class.html)
class of [could_firestore](https://pub.dev/packages/cloud_firestore).
So you can use the instance of `SumibiFirestore` as `Firestore`.
