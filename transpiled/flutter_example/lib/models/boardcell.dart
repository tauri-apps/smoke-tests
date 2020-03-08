class BoardCell {
  int row, column;
  int number = 0;
  bool isMerged = false;
  bool isNew = false;

  BoardCell({this.row, this.column, this.number, this.isNew});

  bool isEmpty() {
    return number == 0;
  }

  @override
  int get hashCode {
    return number.hashCode;
  }

  @override
  bool operator ==(other) {
    return other is BoardCell && number == other.number;
  }
}
