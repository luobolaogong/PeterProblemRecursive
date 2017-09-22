import 'dart:math';

main(List<String> arguments) {
  int minDigits = 4;
  int maxDigits = 4;
  int minBase = 10;
  int maxBase = 10;
  print("Starting at " + (new DateTime.now()).toString());
  Stopwatch stopWatch = new Stopwatch();
  for (int base = minBase; base <= maxBase; base++) {
    for (int nDigits = minDigits; nDigits <= maxDigits; nDigits++) {
      stopWatch.start();
      unabomb(base, nDigits);
      stopWatch.stop();
      print("\tProcessed ${nDigits}-digit numbers in base $base in ${stopWatch.elapsed.inMilliseconds} milliseconds.");
      stopWatch.reset();
    }
  }
  print("Finished at " + (new DateTime.now()).toString());
}

List<int> digits;

unabomb(int base, int nDigits) {
  int digitPosition = 0;
  digits = new List<int>.filled(nDigits, 0);
  generateDigitsRecursively(base, nDigits, digitPosition);
}

// digitPosition is related to recursion depth I believe
void generateDigitsRecursively(int base, int nDigits, int digitPosition) {
  //print("In generateDigitsRecursively, DigitPosition: $digitPosition");
  for (int digitValue = 0; digitValue < base; digitValue++) {
    digits[digitPosition] = digitValue;
    //print("digitValue: $digitValue, digits: $digits");
    if (digitPosition < nDigits - 1) {
      //print("Calling recursion.");
      generateDigitsRecursively(base, nDigits, digitPosition + 1);
      //print("Back from recursion.");
    }
    else {
      List<int> forwardNumberList = digits;
      if (forwardNumberList[0] == 0 || forwardNumberList[nDigits - 1] == 0) {
        //print("Skipping number not right size");
        continue; // skip numbers not right size
      }
      List<int> reversedNumberList = new List<int>.from(digits.reversed);
      int forwardNumber = 0;
      int reversedNumber = 0;
      for (int digitPositionCtr = 0; digitPositionCtr < nDigits; digitPositionCtr++) {
        forwardNumber = forwardNumber + forwardNumberList.elementAt(digitPositionCtr) * pow(base, nDigits - digitPositionCtr - 1);
        reversedNumber = reversedNumber + reversedNumberList.elementAt(digitPositionCtr) * pow(base, nDigits - digitPositionCtr - 1);
      }
      if (forwardNumber == reversedNumber) {
        continue; // skip numbers where multiple is 1
      }
      int mDivNRemainder = reversedNumber % forwardNumber;
      if (mDivNRemainder == 0) {
        int wholeNumberMultiple = reversedNumber ~/ forwardNumber;
        print("Base $base, digits:$nDigits, n: ${forwardNumber.toRadixString(base)}, m: ${reversedNumber.toRadixString(base)},  ${wholeNumberMultiple.toRadixString(base)} * ${forwardNumber.toRadixString(base)} == ${reversedNumber.toRadixString(base)}");
        continue;
      }
    }
  }
}
