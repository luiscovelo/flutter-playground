abstract class FailureSearch implements Exception {}

class InvalidTextError implements FailureSearch {}

class EmptyTextError implements FailureSearch {}

class DatasourceError implements FailureSearch {}
