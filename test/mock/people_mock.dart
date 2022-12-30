class PeopleMock {
  PeopleMock();

  factory PeopleMock.fromJson(Map<String, dynamic> row) {
    late final _ = row['vlues'];
    return PeopleMock();
  }
}
