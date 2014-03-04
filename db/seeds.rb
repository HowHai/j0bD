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


def random_name
  %w[Elwanda Roff Trinh Manfredi Matilda Mazon Francisco Wendell Timika Garand Russ Harms Kathe Byron Alma Kott Alexis Westerfield Merilyn Blakeney Jasmin Bruns Ned Leiva Kristie Bartos Rueben Krupa Myung Reddington Regine Ferron Adrianne Gruner Aimee Prendergast Riley Paladino Maisha Farnsworth].sample
end

# Generate random employees
15.times do
  Employee.create(name: random_name)
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
