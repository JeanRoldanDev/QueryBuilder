enum WhereType {
  equal('='),
  greaterThan('>'),
  lessThan('<'),
  greaterThanOrEqual('>='),
  lessThanOrEqual('<='),
  like(' LIKE '),
  ;

  const WhereType(this.value);
  final String value;
}
