import 'package:timeline/data/enums.dart';
import 'package:timeline/model/game_card.dart';

List<GameCard> cardListOnHand = [
  GameCard(
      name: "Паровой двигатель",
      year: 1698,
      date: DateTime(1698, 07, 02),
      description:
          "2 июля 1698 года — английский механик Томас Севери патентует первый паровой двигатель. Сама по себе «машина Севери» представляла собой обычный паровой насос без деталей, приводимых в движение. Однако эта разработка позволила последователям Севери внедрить в механические устройства реальные паровые двигатели."
          " Первый прототип паровоза был сконструирован во Франции военным инженером Николя-Жозе Кюньо уже в 1769 году. Железнодорожные составы, первые автомобили, корабли, станки на заводах и фабриках, моторизированная сельхозтехника — все это работало на пару. Именно разработка парового двигателя дала старт промышленной революции XVIII—XIX веков.",
      source: "https://www.gutenberg.org/files/46879/46879-h/46879-h.htm",
      author: "Томас Севери",
      category: Category.inventions,
      geography: Geography.allWorld,
      century: Century.XVII),
  GameCard(id: 4, name: "Рождение фотографии", year: 1839, category: Category.opens, century: Century.earlier),
  GameCard(id: 4, name: "Патент на телефон", year: 1876, category: Category.inventions, century: Century.XIV),
  GameCard(id: 4, name: "Лампа накаливания", year: 1879, category: Category.opens, century: Century.XIX),
  GameCard(id: 4, name: "Автомобиль с ДВС", year: 1886, category: Category.inventions, century: Century.earlier),
  GameCard(id: 4, name: "Асинхронный электродвигатель", year: 1888, category: Category.inventions, century: Century.earlier),
  GameCard(id: 4, name: "Радиоприемник", year: 1895, category: Category.inventions, century: Century.earlier),
  GameCard(id: 4, name: "Рентген", year: 1895, category: Category.inventions, century: Century.earlier),
  GameCard(id: 4, name: "Первый полет", year: 1903, category: Category.inventions, century: Century.earlier),
  GameCard(id: 4, name: "Пеницилин", year: 1928, category: Category.inventions, century: Century.earlier),
  GameCard(id: 4, name: "Компьютер", year: 1946, category: Category.inventions, century: Century.earlier),
  GameCard(id: 4, name: "Лазер", year: 1951, category: Category.inventions, century: Century.earlier),
  GameCard(id: 4, name: "Искусственный интеллект", year: 1956, category: Category.inventions, century: Century.earlier),
  GameCard(id: 4, name: "Промышленный робот", year: 1961, category: Category.inventions, century: Century.earlier),
  GameCard(id: 4, name: "Сотовый телефон", year: 1973, category: Category.inventions, century: Century.earlier),
  GameCard(id: 4, name: "3D принтер", year: 1983, category: Category.inventions, century: Century.earlier),
  GameCard(id: 4, name: "Интернет", year: 1991, category: Category.inventions, century: Century.earlier),
];
