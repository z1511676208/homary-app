class Watcher {
  static List<double> productListItemHeight = [];
  static List<double> itemOffsetList = [];

  static bool isTap = false;

  static refreshParams() {
    Watcher.productListItemHeight = [];
    Watcher.itemOffsetList = [];
    Watcher.isTap = false;
  }
}
