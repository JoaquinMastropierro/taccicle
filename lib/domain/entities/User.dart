class User {
    User({
        required this.idUser,
        required this.name,
        this.email,
    });

    int idUser;
    String name;
    dynamic email;

    factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["idUser"],
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "name": name,
        "email": email,
    };

    static String? validateUsername(String? username){
      
      if(username == null) return "Minimo 4 caracteres";

      if(username.length < 4) return "Minimo 4 caracteres";

      final validCharacters = RegExp(r'^[A-Za-z][A-Za-z0-9_]{3,29}$');

      bool esValido = validCharacters.hasMatch(username);

      if(!esValido) return "No se aceptan caracteres especiales";

      return null;
    }
}
