# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create([
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
           )
Category.create([
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
               )
que1 = Question.new(title: 'Who is the prime minister of nepal')
que1.options.new([
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
                )
que1.categories = [Category.first, Category.second]
que1.save!
que2 = Question.new(title: 'Which country won FIFA worldcup 2018')
que2.options.new([
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
                )
que2.categories = [Category.last, Category.second]
que2.save!
que3 = Question.new(title: 'Who is the father of C programming language')
que3.options.new([
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
                )
que3.categories = [Category.last, Category.second]
que3.save
que4 = Question.new(title: 'What does the Olympic Flame symbolize?')
options = que4.options.new([
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
                          )
que4.categories = [Category.first, Category.second]
que4.save
que5 = Question.new(title: 'Who was the 2018 Wisden Leading Cricketer in the world?')
options = que5.options.new([
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
                          )
que5.categories = [Category.first, Category.last]
que5.save
que6 = Question.new(title: 'Which technology company has launched a campaign named ‘Make Small Strong’?')
options = que6.options.new([
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
                          )
que6.categories = [Category.first, Category.third]
que6.save
que7 = Question.new(title: 'Who founded Apple COmputer')
options = que7.options.new([
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
                          )
que7.categories = [Category.second, Category.third]
que7.save
que8 = Question.new(title: 'What is the name for a pointing ')
options = que8.options.new([
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
                          )
que8.categories = [Category.second, Category.third]
que8.save
que9 = Question.new(title: 'When was the DVD introduced? ')
options = que9.options.new([
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
                          )
que9.categories = [Category.second, Category.third, Category.last]
que9.save
que10 = Question.new(title: 'Who is the maker of the iPhone ')
options = que10.options.new([
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
                           )
que10.categories = [Category.second, Category.third, Category.last]
que10.save
que11 = Question.new(title: 'Which of these is a file format for digital images? ')
options = que11.options.new([
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
                           )
que11.categories = [Category.second, Category.third, Category.last]
que11.save
que12 = Question.new(title: 'Which of these is not a telephone?')
options = que12.options.new([
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
                           )
que12.categories = [Category.second, Category.third, Category.last]
que12.save
que13 = Question.new(title: 'Who is the father of History')
options = que13.options.new([
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
                           )
que13.categories = [Category.second, Category.last]
que13.save
que14 = Question.new(title: 'Who built Great Wall of CHina')
options = que14.options.new([
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
                           )
que14.categories = [Category.second, Category.last]
que14.save
que15 = Question.new(title: 'The founder of the religion. Zoroastrianism?')
options = que15.options.new([
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
                           )
que15.categories = [Category.second, Category.last]
que15.save
que16 = Question.new(title: 'The most famous student of Socrates?')
options = que16.options.new([
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
                           )
que16.categories = [Category.second, Category.last]
que16.save
que17 = Question.new(title: 'Which country came to be called “the nest of singing birds”?')
options = que17.options.new([
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
                           )
que17.categories = [Category.second, Category.last]
que17.save
que18 = Question.new(title: 'Neandertal Valley is in :')
options = que18.options.new([
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
                           )
que18.categories = [Category.second, Category.last]
que18.save
que19 = Question.new(title: 'Cro-Magnon is in:')
options = que19.options.new([
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
                           )
que19.categories = [Category.second, Category.last]
que19.save
que20 = Question.new(title: 'Which country discovered Copper?')
options = que20.options.new([
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
                           )
que20.categories = [Category.second, Category.last]
que20.save
que21 = Question.new(title: 'What sport is best known as the ‘king of sports’?')
options = que21.options.new([
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
                           )
que21.categories = [Category.first, Category.third]
que21.save
que22 = Question.new(title: 'What is the national sport of Canada?')
options = que22.options.new([
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
                           )
que22.categories = [Category.first, Category.third]
que22.save
que23 = Question.new(title: 'How many dimples does an average golf ball have?')
options = que23.options.new([
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
                           )
que23.categories = [Category.first, Category.third]
que23.save
que24 = Question.new(title: 'How many players are on a baseball team?')
options = que24.options.new([
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
                           )
que24.categories = [Category.first, Category.third]
que24.save
que25 = Question.new(title: 'In soccer, what body part can’t touch the ball?')
options = que25.options.new([
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
                           )
que25.categories = [Category.first, Category.third]
que25.save
