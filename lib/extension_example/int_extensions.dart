extension IntExtensions on int {
  bool isFive() {
    return this == 5;
  }
}

void main() {
  const int toto = 5;
  print(toto.isFive());
}