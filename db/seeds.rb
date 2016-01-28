  #Score Weight Seeds
  Weight.create(value: 2)
  Weight.create(value: -2)

  #Pattern Seeds
  Pattern.create(score_pattern: '[aeiou]', description: "Password Contains Vowel", weight_id: 1)
  Pattern.create(score_pattern: '([abcdfghijklmnpqrstuvwxyz])\1', description: "Password Contains two consecutive letters other then 'ee' and 'oo'.", weight_id: 2)
  Pattern.create(score_pattern: '([a-z])\1\1', description: "Password contains uppercase letters or digits.", weight_id: 2)
  Pattern.create(score_pattern: '.{8,}', description: "Length greater then 8.", weight_id: 1)
  Pattern.create(score_pattern: '.{14,}', description: "Length greater then 14.", weight_id: 1)
