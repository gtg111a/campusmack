def random_url
  [ Faker::Internet.domain_word,
    Faker::Internet.domain_name,
    Faker::Internet.domain_suffix
  ].join(".")
end