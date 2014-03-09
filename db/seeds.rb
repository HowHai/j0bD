# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Employee.destroy_all
Employer.destroy_all
StackOverflowAccount.destroy_all
StackTag.destroy_all
GithubAccount.destroy_all
GithubRepo.destroy_all
Dribbble.destroy_all
LinkedIn.destroy_all
Position.destroy_all
Education.destroy_all


if true
  def random_name
    %w[Elwanda Roff Trinh Manfredi Matilda Mazon Francisco Wendell Timika Garand Russ Harms Kathe Byron Alma Kott Alexis Westerfield Merilyn Blakeney Jasmin Bruns Ned Leiva Kristie Bartos Rueben Krupa Myung Reddington Regine Ferron Adrianne Gruner Aimee Prendergast Riley Paladino Maisha Farnsworth].sample
  end

  # Create different linkedin positions
  # Random titles
  def random_position_title
    ['Web Designer', 'Front End Developer', 'Front End Engineer', 'JavaScript Developer', 'JavaScript Engineer', 'Visual Designer', 'UX Designer', 'Interaction Designer', 'Web Developer', 'Full Stack Developer', 'Web Programmer', 'Web Application Developer', 'Rails Developer', 'Back End Developer'].sample
  end

  # Create a random summary with random job related keywords added in
  def random_position_summary
    random_skills = ['HTML', 'PHP', 'CSS3', 'CSS', 'JavaScript', 'jQuery', 'ajax', 'ruby', 'ruby on rails', 'coffeescript', 'pythong', 'c', 'viml', 'Go', 'Clojure', 'Prolog', 'haskell', 'perl', 'lua', 'scala']

    random_summary = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet, maxime, praesentium, rem ducimus iusto harum perferendis officiis numquam veritatis nobis accusamus laborum dolor nihil dolores cum ex beatae nostrum totam. "

    # Add 3 random skills to summary
    3.times do
      random_summary += random_skills.sample + " "
    end
    random_summary
  end

  #
  def random_languages
    languages = ""
    4.times do
      lang = %w[English Vietnamese Spanish French Japanese Chinese Korean Tagalog].sample
      languages += lang
    end
  end

  # Create github repo
  def repos_languages_data(git_user)
    allRepos = []
    github = Github.new oauth_token: 'ffd9e5f6f29580ec5f8f1e610e4a55a97af70055'
    myRepos = github.repos.list user: git_user
    myRepos.each do |repo|
      repo_languages = github.repos.languages git_user, repo.name
      repoHash = repo_languages.to_hash
      repoHash["name"] = repo.name
      repoHash["created_at"] = repo.created_at
      repoHash["updated_at"] = repo.updated_at
      allRepos.push(repoHash.symbolize_keys!)
    end
    allRepos
  end

  # Create stack
  def get_stack_user_info(user_id)
    user_info = HTTParty.get("https://api.stackexchange.com/2.2/users/" + user_id + "?order=desc&sort=reputation&site=stackoverflow&filter=!406FePY_tk75WKBzx&key=d9Fe13Jxvcb)WMzdPi8t7A((")

    user_info = user_info["items"][0]
    total_badges = user_info["badge_counts"].values.sum
    stack_info = {id: user_id, reputation: user_info["reputation"], age: user_info["age"].to_i, badge_counts: total_badges}
    stack_info
  end

  # Generate random numbers
  def random_number
    rand(700-1)
  end

  # Create dribbble account
  def create_dribbble_account(employee)
    drib_info = {
      username:                 random_name,
      shots_count:              random_number,
      likes_count:              random_number,
      likes_received_count:     random_number,
      rebounds_count:           random_number,
      rebounds_received_count:  random_number
    }
    employee.create_dribbble(drib_info)
  end


  ########## Make Fake profiles  ###########
  ########## 1
  employee = Employee.create(name: random_name)

  employee.create_linked_in({headline: "Developer in Residence at General Assemb.ly", industry: "Computer Software", summary: "Awesome sublimetext theme for presentation.", skills: "html, web development, javascript, social networking, sql, css, sharepoint, project management, software documentation, technical writing", languages: "English, French"})

  employee.linked_in.positions.create(
  {company_name: "general Assemb.ly",title: "Developer in Residence", summary: "Teaches front-end and back-end web development, and associated computer science topics, to evening and immersive students.", start_date: Date.new(2013,9), end_date: Time.now}
    )

  employee.linked_in.positions.create(
  {company_name: "general Assemb.ly", title: "Producer -- C&W/AD", summary: "• Helped establish the General Assembly campus in Los Angeles via the coordination of classes, workshops, and social events.
  • Served as a brand ambassador, introducing new students, instructors, and partners to the campus and mission of General Assembly.
  • Designed and edited workshop curricula, promotional copy, and other assets.
  • Provided thoughtful and strategic advice for students seeking continuing education in the areas of design, entrepreneurship, and technology.", start_date: Date.new(2013, 5), end_date: Date.new(2013, 9)}
    )

  employee.linked_in.positions.create(
  {company_name: "Games.com", title: "Developer Evangelist", summary: "• Engaged with developers, publishers, students, and other game industry professionals at events and via social media; built relationships and fostered a developer community around the Games.com platform before and during its launch.
  • Created unique, informative content (games, blog posts, code samples, tweets, etc) to educate and inspire developers.
  • Served as an approachable expert on the Games.com API and other platform resources.
  • Ran, organized, and attended hackathons, game jams, competitions, meetups, conferences, and other events as a representative of the Games.com brand.
  • Collected feedback from the developer community to help the Games.com team evolve and improve the developer experience.
  • Assisted the business development team with lead generation and developer outreach.", start_date: Date.new(2012, 10), end_date: Date.new(2013, 5)}
    )

  employee.linked_in.positions.create(
  {company_name: "JPMorgan Chase", title: "Analytics Developer", summary: "• Pitched, designed, and coded user-developed business application for migrations team specialists and management.
  • Guided development of group's business processes with data-driven focus.
  • Increased automation of internal reporting package to improve quality and efficiency of reports used by colleagues and management.
  • Conducted extensive validation and clean-up of critical migrations-related data.
  • Developed custom special-use applications for technical writing and documentation team.
  • Served as group's subject-matter expert for SharePoint 2007 and related applications.
  • Provided project updates and design walkthroughs during team lead and project management meetings.", start_date: Date.new(2011, 4), end_date: Date.new(2012, 8)}
    )

  employee.linked_in.positions.create(
  {company_name: "American Optometric Association", title: "Assistant, Paraoptometric Section", summary: " Streamlined continuing education submission and recordkeeping processes with use of web forms and updated departmental policies.
  • Established social media strategy for department, created and maintained social networking accounts and blog, familiarized colleagues with social media/new media.
  • Served as Basecamp administrator, assisted with project management and process evaluation for multiple committees and departments, introduced volunteers and staff to project management principles and software.
  • Maintained department web pages, created interactive web content to add value to association memberships, trained colleagues on use of CMS and basic HTML.
  • Edited and assisted with development of continuing education articles and interactive modules.
  • Devised long-term strategies for improvements to databases, membership application, and continuing education program.", start_date: Date.new(2009, 8), end_date: Date.new(2010, 12)}
    )

  employee.linked_in.educations.create(
  {degree: "B.A., Economics", field_of_study: "International Studies", school_name: "University of Dayton"}
    )

  employee.linked_in.educations.create(
  {degree: "M.S.", field_of_study: "Software Engineering", school_name: "DePaul University"}
    )

  # Github account
  git1 = employee.create_github_account({
    provider: 'github',
    uid: '838283',
    username: 'justinlala',
    oauth_token: 'fsljffew9fw923jfeljf4dos04'
    })

  # Create stack overflow account and tags
  stack_info1 = get_stack_user_info('22224')
  stack_user1 = employee.create_stack_overflow_account(stack_info1)
  stack_user1.create_tags

  allRepos1 = repos_languages_data('justinlala')
  allRepos1.each do |repo|
    git1.github_repos.create(repo)
  end

  # Create Dribbble account
  employee.create_dribbble({
    username:                 random_name,
    shots_count:              49,
    likes_count:              230,
    likes_received_count:     899,
    rebounds_count:           4,
    rebounds_received_count:  2
  })

  ########### 2

  employee2 = Employee.create(name: random_name)

  employee2.create_linked_in(
  {headline: "Developer at Cloudy Hills", industry: "Internet", summary: "-Solid understanding of front-end development, including HTML5, CSS3, Javascript, JQuery, and Angular.js

  -Extensive experience with PHP, from legacy 1990's code to modern MVC frameworks. I have worked with the following frameworks : Symphony2, Zend, Laravel, CodeIgniter, CakePHP, Phalcon

  -Databases - Deep understanding of database structure and architechture, with extensive experience with complex database creation, maintanence, and traversal. I have mainly worked with mysql, using raw queries, pdo, and orms.", skills: "PHP, Javascript, jquery, mysql, java, html, css, symfony, c, c++", languages: "English"
  }
    )

  employee2.linked_in.positions.create(
  {company_name: "Cloudy Hills", title: "Developer", summary: "PHP/MySql/Symfony2/Javascript/JQuery/Mobile/Ajax/Html5/css3/AngularJS

  Development and consulting on wide variety of websites and applications, both previously existing and built from the ground up. Specializing in both backend and frontend development for larger scale applications.", start_date: Date.new(2013, 3), end_date: Time.now}
    )

  employee2.linked_in.positions.create(
  {company_name: "Book a Band", title: "Developer/Designer", summary: "Bookaband.com is a one stop place to find and book a local band for your awesome events.

  Late 2012, Dave Seideman, founder of bookaband.com decided to do an overhaul of the 10+ year old website system that is currently in place.

  This website was built from the ground up, based from the php symfony2 framework, and utilizes javascript, jquery, and several awesome external API's such as indextank and stripe.", start_date: Date.new(2012, 9), end_date: Date.new(2013, 6)}
    )

  employee2.linked_in.positions.create(
  {company_name: "Prelude Interactive", title: "Developer", summary: "Prelude Interactive is a technology company in Austin, Texas, specializing in nonprofit and cause focused software, tools, and processes.

  Assigned a wide variety of projects including focuses on php script development, research, salesforce integration, and data analysis.", start_date: Date.new(2012, 3), end_date: Date.new(2013, 3)}
    )


  employee2.linked_in.positions.create(
  {company_name: "Wisga.com", title: "Developer", summary: "Wisga is an exciting student project, created and founded by students at Rice University which helps college students gain leverage in finding internship or research opportunities through the experiences of other people they know or would have the opportunity to meet.

  Being one of the initial developers, this was a life-changing experience where I was able to be immersed in every dimension of web development, and gain the skill sets necessary to begin my career as a developer.

  Developed initial front end and back end functionality; PHP, Javascript, Jquery
  Developed relational database schema: MySql", start_date: Date.new(2011, 3), end_date: Date.new(2012, 8)}
    )

  employee2.linked_in.educations.create(
  {degree: "Bachelor of Arts", field_of_study: "Computer and Electrical Engineering", school_name: "University of Texas at Austin"}
    )

    # Github account
  git2 = employee2.create_github_account({
    provider: 'github',
    uid: '838283',
    username: 'fernvilla',
    oauth_token: 'fsljffew9fw923jfeljf4dos04'
    })

  # Create stack overflow account and tags
  stack_info2 = get_stack_user_info('5445')
  stack_user2 = employee2.create_stack_overflow_account(stack_info2)
  stack_user2.create_tags

  allRepos2 = repos_languages_data('fernvilla')
  allRepos2.each do |repo|
    git2.github_repos.create(repo)
  end

  employee2.create_dribbble({
    username:                 random_name,
    shots_count:              9,
    likes_count:              30,
    likes_received_count:     99,
    rebounds_count:           1,
    rebounds_received_count:  2
  })

  ########## 3

  employee3 = Employee.create(name: random_name)

  employee3.create_linked_in(
  {headline: "Full Stack / Python Developer", industry: "Internet", summary: "+ Python/Django front and back-end application developer
  + Database administration, design and optimization in PostgreSQL and MySQL
  + Linux system administration, bash scripting, cloud scale automation
  + Built various types of web scraping applications using celery, tornado, twisted, etc.
  + Knowledgeable in OOP programming concepts and design patterns
  + Experience using and building REST/SOAP web service interfaces
  + Extensive game development skills in HTML5 canvas and Adobe Flash
  + Competent in marking up webpage layouts using HTML, CSS, JavaScript and jQuery
  + Version control using Git, Mercurial and Subversion", skills: "subversion, mysql, javascript, git, actionscript, css, facebook api, php, apache, flash", languages: "English, Spanish, Chinese"}
    )

  employee3.linked_in.positions.create(
  {company_name: "Self Employed", title: "Full Stack Developer / DevOp", summary: "Python: Django, CherryPy, SQLAlchemy, boto, supervisor, celery, numpy, scipy
  SysAdmin: nginx, Apache, Puppet, Chef, Bash, memcached, AWS
  Database: PostgreSQL, MySQL, DynamoDB
  VCS: Git, Mercurial", start_date: Date.new(2012, 10), end_date: Time.now}
    )


  employee3.linked_in.positions.create(
  {company_name: "Ralp", title: "Developer", summary: "PHP, Flash, Python, JavaScript, CSS, HTML, MySQL, Apache, Bash, Git, Rackspace", start_date: Date.new(2011, 4), end_date: Date.new(2012, 10)}
    )

  employee3.linked_in.positions.create(
  {company_name: "Oddcast", title: "Developer", summary: "Flash, JavaScript, HTML, CSS, PHP, Subversion", start_date: Date.new(2007, 7), end_date: Date.new(2011, 4)}
    )


  employee3.linked_in.educations.create(
  {degree: "Music", field_of_study: "Sound Design", school_name: "Berklee College of Music"}
    )


  employee3.linked_in.educations.create(
  {degree: "B.A.", field_of_study: "Computer Science, Web Development", school_name: "Florida State University"}
    )


    # Github account
  git3 = employee3.create_github_account({
    provider: 'github',
    uid: '838283',
    username: 'elliehoshi',
    oauth_token: 'fsljffew9fw923jfeljf4dos04'
    })

  # Create stack overflow account and tags
  stack_info3 = get_stack_user_info('35364')
  stack_user3 = employee3.create_stack_overflow_account(stack_info3)
  stack_user3.create_tags


  allRepos3 = repos_languages_data('elliehoshi')
  allRepos3.each do |repo|
    git3.github_repos.create(repo)
  end

  employee3.create_dribbble({
    username:                 random_name,
    shots_count:              56,
    likes_count:              130,
    likes_received_count:     499,
    rebounds_count:           11,
    rebounds_received_count:  2
  })
end
