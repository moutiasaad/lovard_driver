enum FilterTypes {
  assigned,
  availableOwn,
  availableOthers,
}

extension FilterTypesExtention on FilterTypes {
  String get value {
    switch (this) {
      case FilterTypes.assigned:
        return 'assigned';
      case FilterTypes.availableOwn:
        return 'available-own';
      case FilterTypes.availableOthers:
        return 'available-others';
    }
  }
}
