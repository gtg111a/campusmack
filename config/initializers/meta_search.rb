
MetaSearch::Where.add :is_like,
  :predicate => :matches_any,
  :types => [:string, :text],
  :formatter => '"%#{param}%"'
