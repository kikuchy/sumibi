part of sumibi;

class _Transaction implements Transaction {
  _Transaction(this._delegate, this._onSetData, this._onUpdateData);

  final Transaction _delegate;
  final Hook _onSetData;
  final Hook _onUpdateData;

  @override
  Future<void> delete(DocumentReference documentReference) =>
      _delegate.delete(documentReference);

  @override
  Future<DocumentSnapshot> get(DocumentReference documentReference) =>
      _delegate.get(documentReference);

  @override
  Future<void> set(
      DocumentReference documentReference, Map<String, dynamic> data) {
    final modified = {...data};
    _onSetData(documentReference.path, modified);
    return _delegate.set(documentReference, modified);
  }

  @override
  Future<void> update(
      DocumentReference documentReference, Map<String, dynamic> data) {
    final modified = {...data};
    _onUpdateData(documentReference.path, modified);
    return _delegate.update(documentReference, modified);
  }
}
