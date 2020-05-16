part of sumibi;

class _WriteBatch implements WriteBatch {
  _WriteBatch(this._delegate, this._onSetData, this._onUpdateData);

  final WriteBatch _delegate;
  final Hook _onSetData;
  final Hook _onUpdateData;

  @override
  Future<void> commit() => _delegate.commit();

  @override
  void delete(DocumentReference document) => _delegate.delete(document);

  @override
  void setData(DocumentReference document, Map<String, dynamic> data,
      {bool merge = false}) {
    final modified = {...data};
    _onSetData(document.path, modified);
    _delegate.setData(document, data, merge: merge);
  }

  @override
  void updateData(DocumentReference document, Map<String, dynamic> data) {
    final modified = {...data};
    _onUpdateData(document.path, modified);
    _delegate.updateData(document, modified);
  }
}
