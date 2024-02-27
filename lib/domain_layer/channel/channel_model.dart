class ChannelModel {
  String? channelID;

  ChannelModel({this.channelID});

  // receive data from server
  factory ChannelModel.fromMap(map) {
    return ChannelModel(channelID: map['channelID']);
  }

  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'channelID': channelID,
    };
  }
}
