List<AgriculturalMachinery> getMachineries(Map<Countries, List<Territory>> territories) {
  final machineries = <AgriculturalMachinery>[];
  
  for (final territoryList in territories.values) {
    for (final territory in territoryList) {
      machineries.addAll(territory.machineries);
    }
  }

  return machineries;
}

double getAverageAge(List<AgriculturalMachinery> machineries) {
  final currentDate = DateTime.now();
  final totalAge = machineries.fold<int>(0, (prev, el) => prev + currentDate.year - el.releaseDate.year);

  return totalAge / machineries.length;
}


void main() {

  // Собираем всю технику
  List<AgriculturalMachinery> allMachineries = getMachineries(mapBefore2010) + getMachineries(mapAfter2010);
  
  // Убираем дубликаты
  List<AgriculturalMachinery> uniqueMachineries = allMachineries.toSet().toList();

  // Вычисляем средний возраст техники
  double averageAge = getAverageAge(uniqueMachineries);

  print('Средний возраст всей техники: $averageAge');

  // Сортируем технику по возрасту
  uniqueMachineries.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));

  // Берём 50% самой старой техники
  List<AgriculturalMachinery> oldestMachineries = uniqueMachineries.sublist(0, (uniqueMachineries.length / 2).round());

  // Вычисляем средний возраст для самой старой техники
  double averageAgeOfOldest = getAverageAge(oldestMachineries);

  print('Средний возраст 50% самой старой техники: $averageAgeOfOldest');
  
}


enum Countries { brazil, russia, turkish, spain, japan }

class Territory {
  int areaInHectare;
  List<String> crops;
  List<AgriculturalMachinery> machineries;

  Territory(
    this.areaInHectare,
    this.crops,
    this.machineries,
  );
}

class AgriculturalMachinery {
  final String id;
  final DateTime releaseDate;

  AgriculturalMachinery(
    this.id,
    this.releaseDate,
  );

  // Переопределяем оператор "==", что бы сравнивать объекты по значению
  @override
  bool operator ==(Object? other) {
    if (other is! AgriculturalMachinery) return false;
    if (other.id == id && other.releaseDate == releaseDate) return true;

    return false;
  }

  @override
  int get hashCode => id.hashCode ^ releaseDate.hashCode;
}

final mapBefore2010 = <Countries, List<Territory>>{
  Countries.brazil: [
    Territory(
      34,
      ['Кукуруза'],
      [
        AgriculturalMachinery(
          'Трактор Степан',
          DateTime(2001),
        ),
        AgriculturalMachinery(
          'Культиватор Сережа',
          DateTime(2007),
        ),
      ],
    ),
  ],
  Countries.russia: [
    Territory(
      14,
      ['Картофель'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Гранулятор Антон',
          DateTime(2009),
        ),
      ],
    ),
    Territory(
      19,
      ['Лук'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Дробилка Маша',
          DateTime(1990),
        ),
      ],
    ),
  ],
  Countries.turkish: [
    Territory(
      43,
      ['Хмель'],
      [
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
        AgriculturalMachinery(
          'Сепаратор Марк',
          DateTime(2005),
        ),
      ],
    ),
  ],
};

final mapAfter2010 = {
  Countries.turkish: [
    Territory(
      22,
      ['Чай'],
      [
        AgriculturalMachinery(
          'Каток Кирилл',
          DateTime(2018),
        ),
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
      ],
    ),
  ],
  Countries.japan: [
    Territory(
      3,
      ['Рис'],
      [
        AgriculturalMachinery(
          'Гидравлический молот Лена',
          DateTime(2014),
        ),
      ],
    ),
  ],
  Countries.spain: [
    Territory(
      29,
      ['Арбузы'],
      [
        AgriculturalMachinery(
          'Мини-погрузчик Максим',
          DateTime(2011),
        ),
      ],
    ),
    Territory(
      11,
      ['Табак'],
      [
        AgriculturalMachinery(
          'Окучник Саша',
          DateTime(2010),
        ),
      ],
    ),
  ],
};
