  #Score Weight Seeds
  Weight.create(value: 2)
  Weight.create(value: -2)

  #Pattern Seeds
  Pattern.create(score_pattern: '[aeiou]', description: "Password Contains Vowel", weight_id: 1)
  Pattern.create(score_pattern: '([abcdfghijklmnpqrstuvwxyz])\1', description: "Password Contains two consecutive letters other then 'ee' and 'oo'.", weight_id: 2)
  Pattern.create(score_pattern: '([a-z])\1\1', description: "Password contains uppercase letters or digits.", weight_id: 2)
  Pattern.create(score_pattern: '.{8,}', description: "Length greater then 8.", weight_id: 1)
  Pattern.create(score_pattern: '.{14,}', description: "Length greater then 14.", weight_id: 1)

  #User Seeds
  User.create(username: 'username1', email: 'emailaddress1@email.com', password: 'passone')
  User.create(username: 'username2', email: 'emailaddress2@email.com', password: 'passone')
  User.create(username: 'username3', email: 'emailaddress3@email.com', password: 'passone')
  User.create(username: 'username4', email: 'emailaddress4@email.com', password: 'passone')
  User.create(username: 'username5', email: 'emailaddress5@email.com', password: 'passtwo')
  User.create(username: 'username6', email: 'emailaddress6@email.com', password: 'passtwo')
  User.create(username: 'username7', email: 'emailaddress7@email.com', password: 'passthree')
  User.create(username: 'username8', email: 'emailaddress8@email.com', password: 'passthree')
  User.create(username: 'username9', email: 'emailaddress9@email.com', password: 'passfour')
  User.create(username: 'username10', email: 'emailaddress10@email.com', password: 'passfour')
