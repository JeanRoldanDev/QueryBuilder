enum WhereType {
  equal('='),
  greaterThan('>'),
  lessThan('<'),
  greaterThanOrEqual('>='),
  lessThanOrEqual('<='),
  between('BETWEEN'),
  like('LIKE'),
  ;

  const WhereType(this.value);
  final String value;
}
