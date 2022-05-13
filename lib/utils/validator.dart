String? validateEmptyTextField(String field, String value) {
  if(value.isEmpty) {
    return "$field must not be empty";
  }
  return null;
}