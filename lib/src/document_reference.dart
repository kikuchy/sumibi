part of sumibi;

class _DocumentReference implements DocumentReference {
  _DocumentReference(this._delegate, this._onSetData, this._onUpdateData);

  final DocumentReference _delegate;
  final Hook _onSetData;
  final Hook _onUpdateData;

  @override
  Firestore get firestore => _delegate.firestore;

  @override
  bool operator ==(dynamic o) =>
      o is _DocumentReference &&
      _delegate == o._delegate &&
      _onSetData == o._onSetData &&
      _onUpdateData == o._onUpdateData;

  @override
  int get hashCode => _delegate.hashCode;

  @override
  CollectionReference parent() =>
      _CollectionReference(_delegate.parent(), _onSetData, _onUpdateData);

  @override
  String get path => _delegate.path;

  @override
  String get documentID => _delegate.documentID;

  @override
  Future<void> setData(Map<String, dynamic> data, {bool merge = false}) {
    final modified = {...data};
    _onSetData(path, modified);
    return _delegate.setData(modified, merge: merge);
  }

  @override
  Future<void> updateData(Map<String, dynamic> data) {
    final modified = {...data};
    _onUpdateData(path, modified);
    return _delegate.updateData(modified);
  }

  @override
  Future<DocumentSnapshot> get({
    platform.Source source = platform.Source.serverAndCache,
  }) =>
      _delegate.get(source: source);

  @override
  Future<void> delete() => _delegate.delete();

  @override
  CollectionReference collection(String collectionPath) => _CollectionReference(
      _delegate.collection(collectionPath), _onSetData, _onUpdateData);

  @override
  Stream<DocumentSnapshot> snapshots({bool includeMetadataChanges = false}) =>
      _delegate.snapshots(includeMetadataChanges: includeMetadataChanges);
}
