enum Level {
  easy("Легкий"),
  normal("Нормальный"),
  hard("Тяжелый");

  final String name;

  const Level(this.name);
}

enum Category {
  brands("Бренды"),
  opens("Открытия"),
  events("События"),
  inventions("Изобретения"),
  buildings("Постройки"),
  wars("Войны и конфликты");

  final String name;

  const Category(this.name);
}

enum Century {
  XXI("XXI"),
  XX("XX"),
  XIX("XIX"),
  XVIII("XVIII"),
  XVII("XVII"),
  XVI("XVI"),
  XV("XV"),
  XIV("XIV"),
  earlier("Ранее");

  final String name;

  const Century(this.name);
}

enum Geography {
  RF("РФ"),
  SNG("СНГ"),
  allWorld("Весь мир");

  final String name;

  const Geography(this.name);
}

enum SettingsType {
  dropDown("dropDown"),
  checkBox("checkBox");

  final String name;

  const SettingsType(this.name);
}
