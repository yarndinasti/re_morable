class MembersModel {
  MembersModel({
    required this.members,
  });
  late final List<Members> members;

  MembersModel.fromJson(Map<String, dynamic> json) {
    members =
        List.from(json['members']).map((e) => Members.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['members'] = members.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Members {
  Members({
    required this.name,
    required this.role,
    required this.slug,
    required this.channelId,
    required this.twitter,
    required this.instagram,
    this.facebook,
    required this.donate,
    required this.description,
    required this.birthday,
    required this.designer,
    required this.height,
  });
  late final String name;
  late final Role role;
  late final String slug;
  late final String channelId;
  late final String twitter;
  late final String instagram;
  late final String? facebook;
  late final Donate donate;
  late final Description description;
  late final String birthday;
  late final String designer;
  late final String height;

  Members.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    role = Role.fromJson(json['role']);
    slug = json['slug'];
    channelId = json['channelId'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    facebook = (json['facebook'] == null) ? null : json['facebook'];
    donate = Donate.fromJson(json['donate']);
    description = Description.fromJson(json['description']);
    birthday = json['birthday'];
    designer = json['designer'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['role'] = role.toJson();
    _data['slug'] = slug;
    _data['channelId'] = channelId;
    _data['twitter'] = twitter;
    _data['instagram'] = instagram;
    _data['facebook'] = facebook;
    _data['donate'] = donate.toJson();
    _data['description'] = description.toJson();
    _data['birthday'] = birthday;
    _data['designer'] = designer;
    _data['height'] = height;
    return _data;
  }
}

class Role {
  Role({
    required this.id,
    required this.en,
  });
  late final String id;
  late final String en;

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['en'] = en;
    return _data;
  }
}

class Donate {
  Donate({
    required this.trakteer,
    this.karyakarsa,
    required this.steamlabs,
  });
  late final String trakteer;
  late final String? karyakarsa;
  late final String steamlabs;

  Donate.fromJson(Map<String, dynamic> json) {
    trakteer = json['trakteer'];
    karyakarsa = (json['karyakarsa'] == null) ? null : json['karyakarsa'];
    steamlabs = json['steamlabs'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['trakteer'] = trakteer;
    _data['karyakarsa'] = karyakarsa;
    _data['steamlabs'] = steamlabs;
    return _data;
  }
}

class Description {
  Description({
    required this.en,
    required this.id,
  });
  late final String en;
  late final String id;

  Description.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['en'] = en;
    _data['id'] = id;
    return _data;
  }
}
