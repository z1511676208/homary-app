class Watcher {
  static List<Map<String, dynamic>> productList = [
    {
      "title": "Wall Lights",
      "info": [
        {"image": "heecvrll", "name": "sdflllkeUwr"},
        {"image": "heecvrll", "name": "wttk"},
        {"image": "heecvrll", "name": "wttk"},
        {"image": "heecvrll", "name": "sdfef * sldfke"},
        {"image": "heecvrll", "name": "wttk"}
      ]
    },
    {
      "title": "Ceiling Lights",
      "info": [
        {"image": "heecvrll", "name": "sdfsdf"},
        {"image": "heecvrll", "name": "wttk"},
        {"image": "heecvrll", "name": "sdfefe"},
        {"image": "heecvrll", "name": "wttk"},
        {"image": "heecvrll", "name": "wsdfsdfttk"}
      ]
    },
    {
      "title": "Renovation Lights",
      "info": [
        {"image": "heecvrll", "name": "welrwler"},
        {"image": "heecvrll", "name": "wttk"},
        {"image": "heecvrll", "name": "sdlfkdf"},
        {"image": "heecvrll", "name": "wttk"},
        {"image": "heecvrll", "name": "ooiuwe"}
      ]
    },
    {
      "title": "Outdoor",
      "info": [
        {"image": "heecvrll", "name": "powerir"},
        {"image": "heecvrll", "name": "cvxv"},
        {"image": "heecvrll", "name": "wtwerwtk"},
        {"image": "heecvrll", "name": "oov"},
        {"image": "heecvrll", "name": "sdfefwwer"}
      ]
    },
    {
      "title": "PetRenov",
      "info": [
        {"image": ";ppe", "name": "wttk"},
        {"image": "heecvrll", "name": "llsdjfe"},
        {"image": "234", "name": "dfkke"},
        {"image": "qwee", "name": "sde"},
        {"image": "dfefe", "name": "dsfefe"},
      ]
    },
  ];

  static List<double> productListItemHeight = [];

  static bool isTap = false;

  static refreshParams() {
    Watcher.productList = [];
    Watcher.productListItemHeight = [];
    Watcher.isTap = false;
  }
}
