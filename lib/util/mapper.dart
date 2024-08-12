abstract class Mapper<Input, SupportingInput, Output> {
  Output mapTo(Input from, SupportingInput? supportingInput);

  List<Output> mapToList(
      List<Input>? listData, SupportingInput? supportingInput) {
    return listData?.map((item) => mapTo(item, null)).toList() ?? List.empty();
  }
}

mixin MapperMixin<Input, SupportingInput, Output>
    on Mapper<Input, SupportingInput, Output> {
  Input mapFrom(Output entity, SupportingInput? supportingInput);

  Input? mapFromNullable(Output? entity, SupportingInput? supportingInput) {
    if (entity == null) {
      return null;
    }

    return mapFrom(entity, supportingInput);
  }

  List<Input>? mapFromNullableList(
      List<Output>? listEntity, SupportingInput? supportingInput) {
    return listEntity?.map((item) => (mapFrom(item, supportingInput))).toList();
  }

  List<Input> mapFromList(
      List<Output>? listEntity, SupportingInput? supportingInput) {
    return mapFromNullableList(listEntity, supportingInput) ?? List.empty();
  }
}
