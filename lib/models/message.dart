class Message {
  final String from;
  final String body;
  final String timestamp;
  final String objectId;

  Message(this.from, this.body, this.timestamp, this.objectId);
}

class Messages {
  List<Message> messages = [];

  void deleteByObjectId(String id) {
    messages.removeWhere((item) => id == item.objectId);
  }

  Messages();

  Messages.mock(int i) {
    for (var j = 0; j < i; j++) {
      this.messages.addAll([
        Message(
            'Aleks',
            'Hi, I am there! This is very long line it is interesting how it will be displayed',
            '2020-03-29 22:01',
            '2'),
        Message('Petras', 'Labas, cia as!\n Second line \n Third line',
            '2020-03-29 22:02', '3'),
        Message('Mario', 'Buon giorno a tutti!', '2020-03-29 22:03', '4'),
      ]);
    }
  }
}
