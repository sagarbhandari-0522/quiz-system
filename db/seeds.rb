# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
users = [
  {
    email: 'admin@gmail.com',
    password: 'password',
    role: 'admin'
  },
  {
    email: 'user1@gmail.com',
    password: 'password',
    role: 'user'
  },
  {
    email: 'user2@gmail.com',
    password: 'password',
    role: 'user'
  }
]
puts '************Creating User **********'
users.each do |user|
  User.create(email: user[:email], password: user[:password], role: user[:role])
end
user_id = User.all.map(&:id)
puts '*************User Created ***********'
categories = [
  {
    name: 'Sports'
  },
  {
    name: 'News'
  },
  {
    name: 'Technology'
  },
  {
    name: 'History'
  }
]
puts '***************Creating Category ************'
categories.each do |category|
  Category.create(name: category[:name])
end
category_id = Category.all.map(&:id)
puts '****************Category Created ************'
puts '**************Creating Question with Options************'
questions = [
  [
    'Who is the prime minister of nepal', [1, 2],
    [
      {
        title: 'Sher Bahadur Deuwa',
        correct: true
      },
      {
        title: 'Puspa Kamal Dahal'
      },
      {
        title: 'Kp oli'
      }
    ]
  ],
  [
    'Which country won FIFA worldcup 2018', [2, 4],
    [
      {
        title: 'Brazil'
      },
      {
        title: 'France',
        correct: true

      },
      {
        title: 'Germany'
      },
      {
        title: 'Nepal'
      }
    ]
  ],
  [
    'Who is the father of C programming language', [2, 4],
    [
      {
        title: 'Richard Trevithick'
      },
      {
        title: 'Yukihiro Matsumoto'

      },
      {
        title: 'Lady Augusta'
      },
      {
        title: 'Dennis Ritchie',
        correct: true

      }
    ]
  ],
  [
    'What does the Olympic Flame symbolize?', [1, 2],
    [
      {
        title: 'Challenge'

      },
      {
        title: 'Continuity',
        correct: true

      },
      {
        title: 'Integrity'

      }
    ]
  ],
  [
    'Who was the 2018 Wisden Leading Cricketer in the world?', [1, 4],
    [
      {
        title: 'Sachin Tendulkar'

      },
      {
        title: 'Virak Kohli',
        correct: true

      },
      {
        title: 'Rohit Sharma'

      },
      {
        title: 'Dhoni'

      }
    ]
  ],
  [
    'Which technology company has launched a campaign named ‘Make Small Strong’?', [1, 3],
    [
      {
        title: 'Microsoft'
      },
      {
        title: 'Google',
        correct: true

      },
      {
        title: 'Amazon'

      },
      {
        title: 'Facebook'

      }
    ]
  ],
  [
    'Who founded Apple Computer', [2, 3],
    [
      {
        title: 'Stephen Fry'

      },
      {
        title: 'Bill Gates'

      },
      {
        title: 'Steve Jobs',
        correct: true

      },
      {
        title: 'Stephen Hawking'

      }
    ]
  ],
  [
    'What is the name for a pointing device', [2, 3],
    [
      {
        title: 'Mouse',
        correct: true

      },
      {
        title: 'Sound Card'

      },
      {
        title: 'Ram'

      },
      {
        title: 'Monitor'

      }
    ]
  ],
  [
    'When was the DVD introduced? ', [2, 3, 4],
    [
      {
        title: '1995',
        correct: true

      },
      {
        title: '1990'

      },
      {
        title: '2000'

      },
      {
        title: '1970'

      }
    ]
  ],
  [
    'Who is the maker of the iPhone ', [2, 3, 4],
    [
      {
        title: 'Microsoft'

      },
      {
        title: 'IBM'

      },
      {
        title: 'Apple',
        correct: true

      },
      {
        title: 'Zenith'

      }
    ]
  ],
  [
    'Which of these is a file format for digital images? ', [2, 3, 4],
    [
      {
        title: 'CIA'

      },
      {
        title: 'IBM'

      },
      {
        title: 'JPG',
        correct: true

      },
      {
        title: 'ICBM'

      }
    ]
  ],
  [
    'Which of these is not a telephone?', [2, 3, 4],
    [
      {
        title: 'IPOD',
        correct: true

      },
      {
        title: 'Razr'

      },
      {
        title: 'Blackberry'

      },
      {
        title: 'Iphone'

      }
    ]
  ],
  [
    'Who is the father of History', [2, 4],
    [
      {
        title: 'Herodotus',
        correct: true

      },
      {
        title: 'Richard Trevithick'
      },
      {
        title: 'Yukihiro Matsumoto'

      },
      {
        title: 'Lady Augusta'
      }
    ]
  ],
  [
    'Who built Great Wall of CHina', [2, 4],
    [
      {
        title: 'Richard Trevithick'
      },
      {
        title: 'Yukihiro Matsumoto'

      },
      {
        title: 'Lady Augusta'
      },
      {
        title: 'Qin Shi Huang',
        correct: true

      }
    ]
  ],
  [
    'The founder of the religion. Zoroastrianism?', [2, 4],
    [
      {
        title: 'Richard Trevithick'
      },
      {
        title: 'Zoroaster',
        correct: true

      },
      {
        title: 'Lady Augusta'
      },
      {
        title: 'Qin Shi Huang'

      }
    ]
  ],
  [
    'The most famous student of Socrates?', [2, 4],
    [
      {
        title: 'Socrates'
      },
      {
        title: 'Plato',
        correct: true

      },
      {
        title: 'Aristotle'
      },
      {
        title: 'None of Above'

      }
    ]
  ],
  [
    'Which country came to be called “the nest of singing birds”?', [2, 4],
    [
      {
        title: 'Nepal'
      },
      {
        title: 'England',
        correct: true

      },
      {
        title: 'Japan'
      },
      {
        title: 'Canada'

      }
    ]
  ],
  [
    'Neandertal Valley is in :', [2, 4],
    [
      {
        title: 'Nepal'
      },
      {
        title: 'England'

      },
      {
        title: 'Japan'

      },
      {
        title: 'Canada',
        correct: true

      }
    ]
  ],
  [
    'Cro-Magnon is in:', [2, 4],
    [
      {
        title: 'Nepal'
      },
      {
        title: 'England'

      },
      {
        title: 'Japan',
        correct: true

      },
      {
        title: 'Canada'

      }
    ]
  ],
  [
    'Which country discovered Copper?', [2, 4],
    [
      {
        title: 'Egypt',
        correct: true

      },
      {
        title: 'England'

      },
      {
        title: 'Japan'

      },
      {
        title: 'Canada'

      }
    ]
  ],
  [
    'What sport is best known as the "king of sports"?', [2, 4],
    [
      {
        title: 'Soccer',
        correct: true

      },
      {
        title: 'Cricket'

      },
      {
        title: 'Badminton'

      },
      {
        title: 'Volleyball'

      }
    ]
  ],
  [
    'What is the national sport of Canada?', [1, 3],
    [
      {
        title: 'Soccer'

      },
      {
        title: 'Cricket'

      },
      {
        title: 'Badminton'

      },
      {
        title: 'Volleyball',
        correct: true

      }
    ]
  ],
  [
    'How many dimples does an average golf ball have?', [1, 3],
    [
      {
        title: '336',
        correct: true

      },
      {
        title: '339'

      },
      {
        title: '233'
      },
      {
        title: '330'
      }
    ]
  ],
  [
    'How many players are on a baseball team?', [1, 3],
    [
      {
        title: '9',
        correct: true

      },
      {
        title: '6'

      },
      {
        title: '7'

      },
      {
        title: '8'

      }
    ]
  ],
  [
    'In soccer, what body part can’t touch the ball?', [1, 3],
    [
      {
        title: 'Foot'

      },
      {
        title: 'Chest'

      },
      {
        title: 'Hand',
        correct: true

      },
      {
        title: 'Nose'

      }
    ]
  ]

]
questions.each do |question, category_ids, options_attributes|
  Question.create(title: question, category_ids: category_ids, options_attributes: options_attributes)
end
puts '*************Questions created with its options*********'
