//Mass
//pound (also lb or #)
//ounce (also oz)
//mg (also milligram or milligramme)
//g (also gram or gramme)
//kg (also kilogram or kilogramme)

import 'dart:math';

void main() {
  Mass();
}

class Mass {
  List<List<double>> _masses;
  List<String> _supportedUnits;
  Map<String, Set<String>> _unitNames;

  Mass() {
    // Create all supported units
    _supportedUnits = [
      'pound',
      'ounce',
      'milligram',
      'gram',
      'kilogram',
    ];
    // Map all abbreviations
    _unitNames = new Map();
    _unitNames[_supportedUnits[0]] = Set.from(["pound", "lb", "#", "pounds"]);
    _unitNames[_supportedUnits[1]] = Set.from(["ounce", "oz", "ounces"]);
    _unitNames[_supportedUnits[2]] = Set.from([
      "mg",
      "mgs",
      "miligram",
      "miligrams",
      "milligramme",
      "milligrammes",
      "milli gram",
      "milli grams",
      "milli-gram",
      "milli-grams",
      "milli gramme",
      "milli grammes",
      "milli-gramme",
      "milli-grammes"
    ]);
    _unitNames[_supportedUnits[3]] =
        Set.from(["g", "gram", "gramme", "grams", "grammes"]);
    _unitNames[_supportedUnits[4]] = Set.from([
      "kg",
      "kgs",
      "kilogram",
      "kilogramme",
      "kilo gram",
      "kilo-gram",
      "kilo gramme",
      "kilo-gramme",
      "kilograms",
      "kilogrammes",
      "kilo grams",
      "kilo-grams",
      "kilo grammes",
      "kilo-grammes"
    ]);
    // Create adjacency matrix
    _initMassMatrix();
//    input.add("2.4 cups sugar");
//    input.add("5 large eggs");
//    input.add("2 2/3 cups milk");
//    input.add("2 teaspoons pure vanilla extract");
//    input.add("3 cups cubed Italian bread");
//    input.add("1/2 cup packed light brown sugar");
//    input.add("A pinch of salt");
    print(_calculateNearestWholeUnit("kg", 1));
    print("");
  }

  Map<String, double> _calculateNearestWholeUnit(String unit, double amount) {
    // Find the unit in supportedUnits
    bool found = false;
    for (String supportedUnit in _supportedUnits) {
      for (String abbreviation in _unitNames[supportedUnit]) {
        if (abbreviation.contains(unit)) {
          // Found
          unit = supportedUnit;
          found = true;
          break;
        }
      }
      if (found) {
        break;
      }
    }
    if (!found) {
      print(
          "You can try fuzzy matching here, but as of now the unit is not supported if it is not found");
      return null;
    }
    // Create all conversions
    int row = _supportedUnits.indexOf(unit);
    List<double> conversions = new List(_masses[row].length);
    double nearestWholeUnit = amount;
    for (int c = 0; c < _masses[row].length; c++) {
      double conversion = _masses[row][c] * amount;
      conversions[c] = conversion;
    }
    // Find nearest whole unit
    List<double> remainders = [0.25, 0.33, 0.5, 0.66, 0.75];
    Map<String, double> possibleAnswers = new Map();
    for (int i = 0; i < conversions.length; i++) {
      double conversion = conversions[i];
      // Prioritization
      // 0.25, 0.5, 0.75, 2 better then 0.375, 0.543
      double remainder =
          _roundDouble((conversion - conversion.toInt()).abs(), 2);
      if (remainder == 0) {
        print("Unit: " +
            _supportedUnits[i] +
            " Amount: " +
            conversion.toString());
        if (conversion < nearestWholeUnit) {
          nearestWholeUnit = conversion;
          unit = _supportedUnits[i];
        }
        possibleAnswers[_supportedUnits[i]] = conversion;
      } else if (remainders.contains(remainder)) {
        if (conversion < nearestWholeUnit) {
          nearestWholeUnit = conversion;
          unit = _supportedUnits[i];
        }
        print("Unit: " +
            _supportedUnits[i] +
            " Amount: " +
            conversion.toString());
        possibleAnswers[_supportedUnits[i]] = conversion;
      }
    }
    //print(possibleAnswers);
//    Tuple2(unit, nearestWholeUnit);
    possibleAnswers["answer-" + unit] = nearestWholeUnit;
    return possibleAnswers;
  }

  double _roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void _initMassMatrix() {
    _masses = List.generate(
        _supportedUnits.length, (i) => List(_supportedUnits.length),
        growable: false);
    //pound, ounce, milligram, gram, kilogram
    // Define all conversions for pound
    _masses[0][0] = 1;
    _masses[0][1] = 16;
    _masses[0][2] = 453592;
    _masses[0][3] = 453.592;
    _masses[0][4] = 0.453592;

    //pound, ounce, milligram, gram, kilogram
    // Define all conversions for ounce
    _masses[1][0] = 0.0625;
    _masses[1][1] = 1;
    _masses[1][2] = 28349.5;
    _masses[1][3] = 28.3495;
    _masses[1][4] = 0.0283495;

    //pound, ounce, milligram, gram, kilogram
    // Define all conversions for milligram
    _masses[2][0] = .00000220462;
    _masses[2][1] = .000035274;
    _masses[2][2] = 1;
    _masses[2][3] = 0.001;
    _masses[2][4] = .000001;

    //pound, ounce, milligram, gram, kilogram
    // Define all conversions for gram
    _masses[3][0] = 0.00220462;
    _masses[3][1] = 0.035274;
    _masses[3][2] = 1000;
    _masses[3][3] = 1;
    _masses[3][4] = 0.001;

    //pound, ounce, milligram, gram, kilogram
    // Define all conversions for kilogram
    _masses[4][0] = 2.20462;
    _masses[4][1] = 35.274;
    _masses[4][2] = 1000000;
    _masses[4][3] = 1000;
    _masses[4][4] = 1;
  }
}
